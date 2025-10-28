import 'package:finanzio/data/repositories/budget_repository.dart';
import 'package:finanzio/domain/models/budget_model.dart';
import 'package:finanzio/domain/models/common/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// State Provider untuk me-refresh list budget
final budgetRefreshProvider = StateProvider<int>((ref) => 0);

// Future Provider yang memantau state refresh
final allBudgetsProvider = FutureProvider<APIListResponse<BudgetModel>>((
  ref,
) async {
  // Watch state refresh
  ref.watch(budgetRefreshProvider);
  return ref.watch(budgetRepositoryProvider).getBudgets();
});

class BudgetScreen extends ConsumerWidget {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetsAsync = ref.watch(allBudgetsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Budget Planner')),
      body: budgetsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (listResponse) {
          if (listResponse.data.isEmpty) {
            return const Center(
              child: Text('Belum ada budget. Tekan + untuk menambah.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: listResponse.data.length,
            itemBuilder: (context, index) {
              final budget = listResponse.data[index];
              return BudgetTile(
                budget: budget,
                formatter: currencyFormatter,
                ref: ref,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke formulir tambah budget
          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddBudgetForm()));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form Budget belum diimplementasi')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BudgetTile extends ConsumerWidget {
  final BudgetModel budget;
  final NumberFormat formatter;
  final WidgetRef ref;

  const BudgetTile({
    required this.budget,
    required this.formatter,
    required this.ref,
  });

  void _deleteBudget(BuildContext context) async {
    try {
      await ref.read(budgetRepositoryProvider).deleteBudget(budget.budgetId);
      ref.read(budgetRefreshProvider.notifier).state++; // Trigger refresh
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Budget berhasil dihapus.')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menghapus: $e')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Asumsi: Budget Amount selalu positif
    final progress = 0.4; // Placeholder: Hitung penggunaan budget (di backend)

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(Icons.monetization_on, color: Colors.blue.shade700),
        title: Text("Kategori ID: ${budget.categoryId.substring(0, 8)}..."),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Batas: ${formatter.format(budget.amountLimit.toDouble())}'),
            LinearProgressIndicator(
              value: progress,
              color: progress > 0.8 ? Colors.red : Colors.green,
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _deleteBudget(context),
        ),
      ),
    );
  }
}
