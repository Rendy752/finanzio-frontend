import 'package:finanzio/data/repositories/transaction_repository.dart';
import 'package:finanzio/domain/models/category_model.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:finanzio/domain/models/transaction_model.dart';
import 'package:finanzio/presentation/screens/transactions/_transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finanzio/presentation/screens/transactions/_transaction_form.dart';
import 'package:finanzio/presentation/screens/transactions/_transfer_form.dart';

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
    try {
      final data = await _repository.getTransactions();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    try {
      await _repository.deleteTransaction(transactionId);
      await fetchTransactions();
    } catch (e) {
      rethrow;
    }
  }
}

enum TransactionTypeFilter { income, expense, transfer }

class TransactionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionListAsync = ref.watch(transactionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.green),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TransactionForm(type: TransactionType.income),
              ),
            ),
            tooltip: 'Tambah Pemasukan',
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TransactionForm(type: TransactionType.expense),
              ),
            ),
            tooltip: 'Tambah Pengeluaran',
          ),
        ],
      ),
      body: TransactionList(transactionListAsync: transactionListAsync),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTransactionTypeSelector(context),
        child: const Icon(Icons.swap_vert),
        tooltip: 'Pilihan Transaksi',
      ),
    );
  }

  void _showTransactionTypeSelector(BuildContext context) {
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
