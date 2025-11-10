import 'package:finanzio/data/repositories/wallet_repository.dart';
import 'package:finanzio/data/repositories/report_repository.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:finanzio/domain/models/transaction_model.dart';
import 'package:finanzio/domain/models/category_model.dart';
import 'package:finanzio/presentation/screens/transactions/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finanzio/presentation/screens/transactions/_transaction_form.dart';

class TransactionList extends ConsumerWidget {
  final AsyncValue<APIListResponse<TransactionModel>> transactionListAsync;

  const TransactionList({required this.transactionListAsync});

  Future<void> _handleDelete(
    BuildContext context,
    WidgetRef ref,
    String transactionId,
  ) async {
    try {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Menghapus transaksi...')));

      await ref
          .read(transactionListProvider.notifier)
          .deleteTransaction(transactionId);

      ref.read(walletListProvider.notifier).fetchWallets();
      ref.invalidate(financialSummaryProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaksi berhasil dihapus.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menghapus transaksi: $e')));
      ref.read(transactionListProvider.notifier).fetchTransactions();
    }
  }

  void _handleEdit(BuildContext context, TransactionModel transaction) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TransactionForm(
          type: transaction.transactionType,
          transactionToEdit: transaction,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(transactionListProvider.notifier).fetchTransactions();
      },
      child: transactionListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (listResponse) {
          if (listResponse.data.isEmpty) {
            return const Center(child: Text('Belum ada transaksi.'));
          }
          return ListView.builder(
            itemCount: listResponse.data.length,
            itemBuilder: (context, index) {
              final txn = listResponse.data[index];
              final isIncome = txn.transactionType == TransactionType.income;

              return Dismissible(
                key: ValueKey(txn.transactionId),

                background: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: const Row(
                    children: [
                      Icon(Icons.edit, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Edit', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),

                secondaryBackground: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.delete, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Hapus', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),

                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    return await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Konfirmasi Hapus'),
                            content: const Text(
                              'Anda yakin ingin menghapus transaksi ini?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(false),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(true),
                                child: const Text(
                                  'Hapus',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ) ??
                        false;
                  } else if (direction == DismissDirection.startToEnd) {
                    _handleEdit(context, txn);
                    return false;
                  }
                  return true;
                },

                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    _handleDelete(context, ref, txn.transactionId);
                  }
                  // Removed the else if for Edit
                },
                child: ListTile(
                  leading: Icon(
                    isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isIncome ? Colors.green : Colors.red,
                  ),
                  title: Text(txn.description),
                  subtitle: Text(
                    '${isIncome ? '+' : '-'} ${txn.amount}',
                    style: TextStyle(
                      color: isIncome ? Colors.green : Colors.red,
                    ),
                  ),
                  trailing: Text(
                    txn.transactionDate.toIso8601String().substring(0, 10),
                  ),
                  onTap: () {
                    _handleEdit(context, txn);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
