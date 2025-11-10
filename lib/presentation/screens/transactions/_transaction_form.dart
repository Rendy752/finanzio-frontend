import 'package:finanzio/data/repositories/category_repository.dart';
import 'package:finanzio/data/repositories/transaction_repository.dart';
import 'package:finanzio/data/repositories/wallet_repository.dart';
import 'package:finanzio/data/repositories/report_repository.dart';
import 'package:finanzio/domain/models/category_model.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:finanzio/domain/models/wallet_model.dart';
import 'package:finanzio/domain/models/transaction_model.dart';
import 'package:finanzio/presentation/screens/transactions/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

class TransactionForm extends ConsumerStatefulWidget {
  final TransactionType type;
  final TransactionModel? transactionToEdit;

  TransactionForm({required this.type, this.transactionToEdit, super.key});

  @override
  ConsumerState<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends ConsumerState<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  String? selectedWalletId;
  String? selectedCategoryId;
  DateTime? selectedDate;
  bool isDateSelectionActive = false;

  CategoryModel? _defaultCategory;

  @override
  void initState() {
    super.initState();
    if (widget.transactionToEdit != null) {
      final txn = widget.transactionToEdit!;
      _amountController.text = txn.amount.toString();
      _descController.text = txn.description;
      selectedDate = txn.transactionDate;
      isDateSelectionActive = true;
    } else {
      Future.microtask(() => _initializeDefaults());
    }
  }

  Future<void> _initializeDefaults() async {
    final walletListNotifier = ref.read(walletListProvider.notifier);

    await walletListNotifier.fetchWallets();
    final walletsAsync = ref.read(walletListProvider);

    APIListResponse<WalletModel>? walletResponse;

    if (walletsAsync is AsyncData<APIListResponse<WalletModel>>) {
      walletResponse = walletsAsync.value;
    } else {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memuat akun. Coba lagi.')),
        );
      }
      return;
    }

    if (walletResponse!.data.isEmpty) {
      if (mounted) {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Anda perlu membuat Akun (Wallet) terlebih dahulu.'),
          ),
        );
      }
      return;
    }

    CategoryModel? defaultCategory;
    try {
      final categoryResponse = await ref.read(categoryListProvider.future);
      final categoryList = categoryResponse.data;

      final defaultCategoryName = widget.type == TransactionType.income
          ? 'Transfer In'
          : 'Transfer Out';

      defaultCategory = categoryList.firstWhere(
        (c) =>
            c.categoryName.toLowerCase() == defaultCategoryName.toLowerCase() &&
            c.type == widget.type,
        orElse: () => categoryList.firstWhere((c) => c.type == widget.type),
      );
    } catch (e) {
      print('Error setting default category: $e');
    }

    if (mounted) {
      setState(() {
        _defaultCategory = defaultCategory;
        selectedCategoryId = _defaultCategory?.categoryId;
      });
    }
  }

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

    final isEditing = widget.transactionToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? 'Edit Transaksi'
              : (widget.type == TransactionType.income
                    ? 'Catat Pemasukan'
                    : 'Catat Pengeluaran'),
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

              if (availableWallets.isEmpty && !isEditing) {
                return const Center(
                  child: Text(
                    'Tidak ada akun. Silakan buat akun terlebih dahulu.',
                  ),
                );
              }

              WalletModel? currentWallet;
              if (isEditing) {
                try {
                  currentWallet = availableWallets.firstWhere(
                    (w) => w.walletId == widget.transactionToEdit!.walletId,
                  );
                } catch (_) {
                  currentWallet = availableWallets.isNotEmpty
                      ? availableWallets.first
                      : null;
                }
              }
              currentWallet ??= availableWallets.isNotEmpty
                  ? availableWallets.first
                  : null;

              if (!isEditing &&
                  selectedWalletId == null &&
                  currentWallet != null) {
                selectedWalletId = currentWallet.walletId;
              }

              return categoriesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) =>
                    Center(child: Text('Error: ${err.toString()}')),
                data: (categoryResponse) {
                  final availableCategories = categoryResponse.data
                      .where((c) => c.type == widget.type)
                      .toList();

                  CategoryModel? currentCategory;
                  if (isEditing) {
                    try {
                      currentCategory = availableCategories.firstWhere(
                        (c) =>
                            c.categoryId ==
                            widget.transactionToEdit!.categoryId,
                      );
                    } catch (_) {
                      currentCategory = _defaultCategory;
                    }
                  }
                  currentCategory ??= _defaultCategory;
                  if (currentCategory == null &&
                      availableCategories.isNotEmpty) {
                    currentCategory = availableCategories.first;
                  }

                  if (!isEditing &&
                      selectedCategoryId == null &&
                      currentCategory != null) {
                    selectedCategoryId = currentCategory.categoryId;
                  }

                  if (!isEditing && currentCategory == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (currentWallet == null) {
                    return const Center(
                      child: Text('Tidak ada akun yang tersedia.'),
                    );
                  }

                  return ListView(
                    children: [
                      DropdownSearch<WalletModel>(
                        selectedItem: currentWallet,
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

                      DropdownSearch<CategoryModel>(
                        selectedItem: currentCategory,
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

                      Row(
                        children: [
                          Checkbox(
                            value: isDateSelectionActive,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isDateSelectionActive = newValue ?? false;
                                if (isDateSelectionActive &&
                                    selectedDate == null) {
                                  selectedDate = DateTime.now();
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (isEditing) {
                              await ref
                                  .read(transactionRepositoryProvider)
                                  .updateTransaction(
                                    widget.transactionToEdit!.transactionId,
                                    selectedWalletId!,
                                    selectedCategoryId!,
                                    widget.transactionToEdit!.transactionType,
                                    Decimal.parse(_amountController.text),
                                    _descController.text,
                                    transactionDate: isDateSelectionActive
                                        ? selectedDate
                                        : null,
                                  );
                            } else {
                              await ref
                                  .read(transactionRepositoryProvider)
                                  .createTransaction(
                                    selectedWalletId!,
                                    selectedCategoryId!,
                                    widget.type,
                                    Decimal.parse(_amountController.text),
                                    _descController.text,
                                    transactionDate: isDateSelectionActive
                                        ? selectedDate
                                        : null,
                                  );
                            }

                            await transactionNotifier.fetchTransactions();
                            await walletNotifier.fetchWallets();
                            ref.invalidate(financialSummaryProvider);

                            if (mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          isEditing
                              ? 'Simpan Perubahan'
                              : 'Simpan ${widget.type == TransactionType.income ? 'Pemasukan' : 'Pengeluaran'}',
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
