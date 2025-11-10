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
              return WalletTile(
                wallet: wallet,
                currencyFormatter: currencyFormatter,
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
            onPressed: () async {
              if (ctx.mounted) Navigator.of(ctx).pop();

              try {
                await ref
                    .read(walletListProvider.notifier)
                    .removeWallet(walletId);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Akun berhasil dihapus.')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Gagal menghapus akun. (Server Error: ${e.toString().contains("500") ? "Pastikan tidak ada transaksi di akun ini." : e.toString()})',
                      ),
                    ),
                  );
                }
              }
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

class WalletTile extends ConsumerWidget {
  final WalletModel wallet;
  final NumberFormat currencyFormatter;
  final Function(String) onDelete;

  const WalletTile({
    required this.wallet,
    required this.currencyFormatter,
    required this.onDelete,
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
        subtitle: Text('Mata Uang: ${wallet.currency}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              // Menggunakan .toDouble() untuk kompatibilitas intl
              currencyFormatter.format(wallet.currentBalance.toDouble()),
              style: TextStyle(
                color: isNegative ? Colors.red.shade700 : Colors.green.shade700,
                fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
