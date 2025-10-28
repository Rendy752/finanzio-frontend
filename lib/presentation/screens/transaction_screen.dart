import 'package:finanzio/data/repositories/category_repository.dart';
import 'package:finanzio/data/repositories/transaction_repository.dart';
import 'package:finanzio/data/repositories/wallet_repository.dart';
import 'package:finanzio/data/repositories/report_repository.dart';
import 'package:finanzio/domain/models/category_model.dart';
import 'package:finanzio/domain/models/transaction_model.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';

enum TransactionTypeFilter { income, expense, transfer }

// StateNotifier untuk mengelola daftar Transaksi
final transactionListProvider =
    StateNotifierProvider<
      TransactionListNotifier,
      AsyncValue<APIListResponse<TransactionModel>>
    >((ref) {
      return TransactionListNotifier(ref.watch(transactionRepositoryProvider));
    });

class TransactionListNotifier
    extends StateNotifier<AsyncValue<APIListResponse<TransactionModel>>> {
  final TransactionRepository _repository;

  TransactionListNotifier(this._repository)
    : super(const AsyncValue.loading()) {
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getTransactions();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

class TransactionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ambil list Transaksi
    final transactionListAsync = ref.watch(transactionListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Transaksi')),
      body: transactionListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (listResponse) {
          return ListView.builder(
            itemCount: listResponse.data.length,
            itemBuilder: (context, index) {
              final txn = listResponse.data[index];
              return ListTile(
                leading: Icon(
                  txn.transactionType == TransactionType.income
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: txn.transactionType == TransactionType.income
                      ? Colors.green
                      : Colors.red,
                ),
                title: Text(txn.description),
                subtitle: Text('Amount: ${txn.amount}'),
                trailing: Text(
                  txn.transactionDate.toIso8601String().substring(0, 10),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTransactionTypeSelector(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTransactionTypeSelector(BuildContext context) {
    // ... (logic selector tetap sama) ...
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.money_off, color: Colors.red),
            title: const Text('Pengeluaran (Expense)'),
            onTap: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      TransactionForm(type: TransactionType.expense),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money, color: Colors.green),
            title: const Text('Pemasukan (Income)'),
            onTap: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TransactionForm(type: TransactionType.income),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.swap_horiz, color: Colors.blue),
            title: const Text('Transfer Dana'),
            onTap: () {
              Navigator.of(ctx).pop();
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const TransferForm()));
            },
          ),
        ],
      ),
    );
  }
}

// Formulir Dasar Transaksi (Income/Expense)
class TransactionForm extends ConsumerWidget {
  final TransactionType type;
  final _amountController = TextEditingController();
  final _descController = TextEditingController();

  TransactionForm({required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ambil daftar Wallet dan Category untuk dropdown
    // Wallets: StateNotifierProvider<WalletListNotifier, AsyncValue<APIListResponse<WalletModel>>>
    final walletsAsync = ref.watch(walletListProvider);

    // Categories: FutureProvider<APIListResponse<CategoryModel>>
    final categoriesAsync = ref.watch(categoryListProvider);

    // FIX: Ambil provider yang dibutuhkan untuk refresh
    final transactionNotifier = ref.read(transactionListProvider.notifier);
    final walletNotifier = ref.read(walletListProvider.notifier);
    final summaryInvalidator = ref.invalidate(financialSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          type == TransactionType.income
              ? 'Catat Pemasukan'
              : 'Catat Pengeluaran',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: walletsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) =>
              Center(child: Text('Error: ${err.toString()}')),
          data: (walletResponse) {
            final availableWallets = walletResponse.data; // FIX: Akses data

            return categoriesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) =>
                  Center(child: Text('Error: ${err.toString()}')),
              data: (categoryResponse) {
                // FIX: Akses data.data (categoryResponse adalah APIListResponse)
                final availableCategories = categoryResponse.data
                    .where((c) => c.type == type)
                    .toList();

                // State lokal untuk Dropdown
                String? selectedWalletId;
                String? selectedCategoryId;

                return Column(
                  children: [
                    // --- Dropdown Wallet ---
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Pilih Akun',
                      ),
                      value: selectedWalletId,
                      items: availableWallets
                          .map(
                            (w) => DropdownMenuItem(
                              value: w.walletId,
                              child: Text(w.walletName),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => selectedWalletId = value,
                    ),
                    // --- Dropdown Category ---
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Pilih Kategori',
                      ),
                      value: selectedCategoryId,
                      items: availableCategories
                          .map(
                            (c) => DropdownMenuItem(
                              value: c.categoryId,
                              child: Text(c.categoryName),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => selectedCategoryId = value,
                    ),
                    // --- Input Jumlah ---
                    TextField(
                      controller: _amountController,
                      decoration: const InputDecoration(labelText: 'Jumlah'),
                      keyboardType: TextInputType.number,
                    ),
                    // --- Input Deskripsi ---
                    TextField(
                      controller: _descController,
                      decoration: const InputDecoration(labelText: 'Deskripsi'),
                    ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedWalletId != null &&
                            selectedCategoryId != null &&
                            _amountController.text.isNotEmpty) {
                          ref
                              .read(transactionRepositoryProvider)
                              .createTransaction(
                                selectedWalletId!,
                                selectedCategoryId!,
                                type,
                                Decimal.parse(_amountController.text),
                                _descController.text,
                              );
                          // Refresh list setelah transaksi
                          transactionNotifier.fetchTransactions();
                          walletNotifier.fetchWallets();
                          ref.invalidate(financialSummaryProvider);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'Simpan ${type == TransactionType.income ? 'Pemasukan' : 'Pengeluaran'}',
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Formulir Khusus Transfer
class TransferForm extends ConsumerWidget {
  const TransferForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Implementasi Form Transfer Dana (Modul 4)
    final walletsAsync = ref.watch(walletListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Transfer Dana')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: walletsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (walletResponse) {
            final availableWallets = walletResponse.data;
            // Lanjutkan dengan formulir transfer (Source Wallet, Target Wallet, Amount)
            return const Text("Formulir Transfer Belum Diimplementasi");
          },
        ),
      ),
    );
  }
}
