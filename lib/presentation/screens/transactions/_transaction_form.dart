import 'package:finanzio/data/repositories/category_repository.dart';
import 'package:finanzio/data/repositories/transaction_repository.dart';
import 'package:finanzio/data/repositories/wallet_repository.dart';
import 'package:finanzio/data/repositories/report_repository.dart';
import 'package:finanzio/domain/models/category_model.dart';
import 'package:finanzio/domain/models/wallet_model.dart';
import 'package:finanzio/presentation/screens/transactions/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

// Formulir Dasar Transaksi (Income/Expense)
class TransactionForm extends ConsumerStatefulWidget {
  final TransactionType type;

  TransactionForm({required this.type, super.key});

  @override
  ConsumerState<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends ConsumerState<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  // State lokal
  String? selectedWalletId;
  String? selectedCategoryId;
  DateTime? selectedDate;
  bool isDateSelectionActive = false; // Checkbox state

  @override
  void dispose() {
    _amountController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletsAsync = ref.watch(walletListProvider);
    final categoriesAsync = ref.watch(categoryListProvider);

    final transactionNotifier = ref.read(transactionListProvider.notifier);
    final walletNotifier = ref.read(walletListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.type == TransactionType.income
              ? 'Catat Pemasukan'
              : 'Catat Pengeluaran',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: walletsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) =>
                Center(child: Text('Error: ${err.toString()}')),
            data: (walletResponse) {
              final availableWallets = walletResponse.data;

              return categoriesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) =>
                    Center(child: Text('Error: ${err.toString()}')),
                data: (categoryResponse) {
                  final availableCategories = categoryResponse.data
                      .where((c) => c.type == widget.type)
                      .toList();

                  return ListView(
                    children: [
                      // --- Dropdown Wallet (Dengan Search) ---
                      DropdownSearch<WalletModel>(
                        // ... (Prop yang sama) ...
                        validator: (v) =>
                            v == null ? 'Pilih Akun sumber' : null,
                        items: availableWallets,
                        itemAsString: (WalletModel w) => w.walletName,
                        onChanged: (WalletModel? w) =>
                            selectedWalletId = w?.walletId,
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: 'Pilih Akun',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // --- Dropdown Category (Dengan Search) ---
                      DropdownSearch<CategoryModel>(
                        // ... (Prop yang sama) ...
                        validator: (v) => v == null ? 'Pilih Kategori' : null,
                        items: availableCategories,
                        itemAsString: (CategoryModel c) => c.categoryName,
                        onChanged: (CategoryModel? c) =>
                            selectedCategoryId = c?.categoryId,
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: 'Pilih Kategori',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // --- Input Jumlah ---
                      TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(
                          labelText: 'Jumlah (Rp)',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v == null ||
                              Decimal.tryParse(v) == null ||
                              Decimal.parse(v) <= Decimal.zero) {
                            return 'Masukkan jumlah yang valid.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // --- Input Deskripsi ---
                      TextFormField(
                        controller: _descController,
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                        ),
                        validator: (v) => v == null || v.isEmpty
                            ? 'Deskripsi tidak boleh kosong'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // --- Checkbox Tanggal (NEW FEATURE) ---
                      Row(
                        children: [
                          Checkbox(
                            value: isDateSelectionActive,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isDateSelectionActive = newValue ?? false;
                                if (isDateSelectionActive &&
                                    selectedDate == null) {
                                  selectedDate =
                                      DateTime.now(); // Set default saat diaktifkan
                                }
                              });
                            },
                          ),
                          const Text('Gunakan tanggal berbeda'),
                          if (isDateSelectionActive)
                            TextButton(
                              onPressed: () => _selectDate(context),
                              child: Text(
                                selectedDate == null
                                    ? 'Pilih Tanggal'
                                    : _dateFormat.format(selectedDate!),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Panggil repository
                            ref
                                .read(transactionRepositoryProvider)
                                .createTransaction(
                                  selectedWalletId!,
                                  selectedCategoryId!,
                                  widget.type,
                                  Decimal.parse(_amountController.text),
                                  _descController.text,
                                  // Mengirim tanggal jika diaktifkan
                                  transactionDate: isDateSelectionActive
                                      ? selectedDate
                                      : null,
                                );

                            // Refresh semua data setelah transaksi
                            transactionNotifier.fetchTransactions();
                            walletNotifier.fetchWallets();
                            ref.invalidate(financialSummaryProvider);
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Simpan ${widget.type == TransactionType.income ? 'Pemasukan' : 'Pengeluaran'}',
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
