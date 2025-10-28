import 'package:finanzio/data/repositories/wallet_repository.dart';
import 'package:finanzio/domain/models/wallet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';

class WalletScreen extends ConsumerWidget {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletListAsync = ref.watch(walletListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Akun (Wallet)')),
      body: walletListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (listResponse) {
          if (listResponse.data.isEmpty) {
            return const Center(
              child: Text('Belum ada akun. Tekan + untuk menambah.'),
            );
          }
          return ListView.builder(
            itemCount: listResponse.data.length,
            itemBuilder: (context, index) {
              final wallet = listResponse.data[index];
              return _WalletItem(
                wallet: wallet,
                formatter: currencyFormatter,
                onDelete: (id) => _confirmDelete(context, ref, id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddWalletDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String walletId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Anda yakin ingin menghapus akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              ref.read(walletListProvider.notifier).removeWallet(walletId);
              Navigator.of(ctx).pop();
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAddWalletDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final balanceController = TextEditingController(text: '0.00');
    String currency = 'IDR';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tambah Akun Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama Akun'),
            ),
            TextField(
              controller: balanceController,
              decoration: const InputDecoration(labelText: 'Saldo Awal'),
              keyboardType: TextInputType.number,
            ),
            // Dalam aplikasi nyata, gunakan Dropdown untuk memilih mata uang
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                ref
                    .read(walletListProvider.notifier)
                    .addWallet(
                      nameController.text,
                      currency,
                      balanceController.text,
                    );
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }
}

class _WalletItem extends StatelessWidget {
  final WalletModel wallet;
  final NumberFormat formatter;
  final Function(String) onDelete;

  const _WalletItem({
    required this.wallet,
    required this.formatter,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isNegative = wallet.currentBalance.compareTo(Decimal.zero) < 0;

    return ListTile(
      leading: const Icon(Icons.account_balance_wallet),
      title: Text(wallet.walletName),
      subtitle: Text('IDR | ${wallet.userId.substring(0, 8)}...'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formatter.format(wallet.currentBalance.toDouble()),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isNegative ? Colors.red.shade700 : Colors.green.shade700,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.grey),
            onPressed: () => onDelete(wallet.walletId),
          ),
        ],
      ),
      onTap: () {
        // Implementasi Edit Wallet
      },
    );
  }
}
