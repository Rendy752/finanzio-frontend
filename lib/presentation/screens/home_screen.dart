import 'package:finanzio/application/providers/auth_provider.dart';
import 'package:finanzio/data/repositories/report_repository.dart';
import 'package:finanzio/data/repositories/wallet_repository.dart';
import 'package:finanzio/domain/models/wallet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';
import 'package:finanzio/domain/models/report_model.dart'; // Import Report Model

class HomeScreen extends ConsumerWidget {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(financialSummaryProvider);
    final walletListAsync = ref.watch(walletListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finanzio Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(financialSummaryProvider);
              ref.read(walletListProvider.notifier).fetchWallets();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(summaryAsync),
            const SizedBox(height: 24),
            Text(
              'My Wallets',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            _buildWalletList(walletListAsync),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(AsyncValue<FinancialSummaryModel> summaryAsync) {
    return Card(
      elevation: 4,
      color: Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: summaryAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) =>
              Text('Error loading summary: ${err.toString()}'),
          data: (summary) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Net Balance',
                style: TextStyle(fontSize: 16, color: Colors.indigo),
              ),
              Text(
                // FIX: Konversi ke double sebelum format
                currencyFormatter.format(summary.netBalance.toDouble()),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: summary.netBalance.compareTo(Decimal.zero) < 0
                      ? Colors.red.shade700
                      : Colors.indigo, // Net Balance warna indigo jika positif
                ),
              ),
              const Divider(),
              _buildSummaryRow(
                'Total Income:',
                summary.totalIncome,
                Colors.green,
              ),
              _buildSummaryRow(
                'Total Expense:',
                summary.totalExpense,
                Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, Decimal amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            // FIX: Konversi ke double sebelum format
            currencyFormatter.format(amount.toDouble()),
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletList(AsyncValue walletListAsync) {
    return walletListAsync.when(
      loading: () => const Center(child: LinearProgressIndicator()),
      error: (err, stack) => Text('Error loading wallets: ${err.toString()}'),
      data: (listResponse) {
        if (listResponse.data.isEmpty) {
          return const Center(
            child: Text('No wallets found. Add one to get started!'),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listResponse.data.length,
          itemBuilder: (context, index) {
            final wallet = listResponse.data[index];
            return WalletTile(
              wallet: wallet,
              currencyFormatter: currencyFormatter,
            );
          },
        );
      },
    );
  }
}

class WalletTile extends ConsumerWidget {
  final WalletModel wallet;
  final NumberFormat currencyFormatter;

  const WalletTile({
    required this.wallet,
    required this.currencyFormatter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tentukan apakah saldo negatif dengan membandingkannya dengan Decimal.zero
    final isNegative = wallet.currentBalance.compareTo(Decimal.zero) < 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: const Icon(Icons.account_balance_wallet, color: Colors.indigo),
        title: Text(
          wallet.walletName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Currency: ${wallet.currency}'),
        trailing: Text(
          // FIX: Konversi ke double sebelum format
          currencyFormatter.format(wallet.currentBalance.toDouble()),
          style: TextStyle(
            color: isNegative ? Colors.red.shade700 : Colors.green.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
