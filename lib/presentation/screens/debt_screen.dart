import 'package:finanzio/data/repositories/debt_repository.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:finanzio/domain/models/debt_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';

// State Provider untuk me-refresh list debt
final debtRefreshProvider = StateProvider<int>((ref) => 0);

// Future Provider yang memantau state refresh
final allDebtsProvider = FutureProvider<APIListResponse<DebtModel>>((
  ref,
) async {
  ref.watch(debtRefreshProvider);
  return ref.watch(debtRepositoryProvider).getDebts();
});

class DebtScreen extends ConsumerWidget {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debtsAsync = ref.watch(allDebtsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Utang & Piutang')),
      body: debtsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (listResponse) {
          if (listResponse.data.isEmpty) {
            return const Center(
              child: Text('Tidak ada catatan utang/piutang.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: listResponse.data.length,
            itemBuilder: (context, index) {
              final debt = listResponse.data[index];
              return DebtTile(
                debt: debt,
                formatter: currencyFormatter,
                ref: ref,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke formulir tambah utang/piutang
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form Debt belum diimplementasi')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DebtTile extends ConsumerWidget {
  final DebtModel debt;
  final NumberFormat formatter;
  final WidgetRef ref;

  const DebtTile({
    required this.debt,
    required this.formatter,
    required this.ref,
  });

  // Logika untuk menampilkan sisa hutang
  Decimal get remainingAmount => debt.totalAmount - debt.amountPaid;

  void _recordPayment(BuildContext context) {
    // Logic PUT /debts/{id} untuk record payment
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur Pembayaran belum aktif')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPayable = !debt.isDebtToUser; // True jika kita berutang (Payable)
    final isSettled = debt.isSettled;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isSettled
          ? Colors.grey.shade200
          : (isPayable ? Colors.orange.shade50 : Colors.green.shade50),
      child: ListTile(
        leading: Icon(
          isPayable ? Icons.call_missed_outgoing : Icons.call_received,
          color: isSettled
              ? Colors.grey
              : (isPayable ? Colors.red : Colors.green),
        ),
        title: Text(
          debt.contactName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(isPayable ? 'Utang' : 'Piutang'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              formatter.format(remainingAmount.toDouble()),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSettled
                    ? Colors.black54
                    : (isPayable ? Colors.red.shade700 : Colors.green.shade700),
              ),
            ),
            Text(
              'Total: ${formatter.format(debt.totalAmount.toDouble())}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        onTap: isSettled ? null : () => _recordPayment(context),
      ),
    );
  }
}
