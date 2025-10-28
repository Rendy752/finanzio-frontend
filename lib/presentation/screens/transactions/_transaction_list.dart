import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:finanzio/domain/models/transaction_model.dart';
import 'package:finanzio/domain/models/category_model.dart';
import 'package:finanzio/presentation/screens/transactions/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionList extends ConsumerWidget {
  final AsyncValue<APIListResponse<TransactionModel>> transactionListAsync;

  const TransactionList({required this.transactionListAsync});

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
            return Center(child: Text('Belum ada transaksi.'));
          }
          return ListView.builder(
            itemCount: listResponse.data.length,
            itemBuilder: (context, index) {
              final txn = listResponse.data[index];
              final isIncome = txn.transactionType == TransactionType.income;
              return ListTile(
                leading: Icon(
                  isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isIncome ? Colors.green : Colors.red,
                ),
                title: Text(txn.description),
                subtitle: Text(
                  // FIX: Menampilkan jumlah dengan tanda +/- yang benar
                  '${isIncome ? '+' : '-'} ${txn.amount}',
                  style: TextStyle(color: isIncome ? Colors.green : Colors.red),
                ),
                trailing: Text(
                  txn.transactionDate.toIso8601String().substring(0, 10),
                ),
                onLongPress: () {
                  // Implementasi hapus/edit transaksi
                },
              );
            },
          );
        },
      ),
    );
  }
}
