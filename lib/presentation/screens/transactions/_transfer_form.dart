import 'package:finanzio/data/repositories/transaction_repository.dart';
import 'package:finanzio/data/repositories/wallet_repository.dart';
import 'package:finanzio/data/repositories/report_repository.dart';
import 'package:finanzio/domain/models/wallet_model.dart';
import 'package:finanzio/presentation/screens/transactions/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';
import 'package:dropdown_search/dropdown_search.dart';

// Formulir Khusus Transfer (Modul 4)
class TransferForm extends ConsumerWidget {
  const TransferForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletsAsync = ref.watch(walletListProvider);
    final txnRepo = ref.read(transactionRepositoryProvider);

    // State lokal untuk form
    String? selectedSourceId;
    String? selectedTargetId;
    final _amountController = TextEditingController();
    final _descController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Transfer Dana Antar Akun')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: walletsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (walletResponse) {
              final availableWallets = walletResponse.data;

              return ListView(
                children: [
                  // --- Dropdown Source Wallet (Dengan Search) ---
                  DropdownSearch<WalletModel>(
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                      title: ListTile(title: Text('Pilih Akun Sumber')),
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Dari Akun (Sumber)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    validator: (v) => v == null ? 'Pilih Akun Sumber' : null,
                    items: availableWallets,
                    itemAsString: (WalletModel w) => w.walletName,
                    onChanged: (WalletModel? w) =>
                        selectedSourceId = w?.walletId,
                  ),
                  const SizedBox(height: 16),

                  // --- Dropdown Target Wallet (Dengan Search) ---
                  DropdownSearch<WalletModel>(
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                      title: ListTile(title: Text('Pilih Akun Tujuan')),
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Ke Akun (Tujuan)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    validator: (v) => v == null ? 'Pilih Akun Tujuan' : null,
                    items: availableWallets,
                    itemAsString: (WalletModel w) => w.walletName,
                    onChanged: (WalletModel? w) =>
                        selectedTargetId = w?.walletId,
                  ),
                  const SizedBox(height: 16),

                  // --- Input Jumlah ---
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Transfer (Rp)',
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
                  // --- Input Deskripsi ---
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi Transfer',
                    ),
                    validator: (v) => v == null || v.isEmpty
                        ? 'Deskripsi tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedSourceId == selectedTargetId) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Sumber dan Tujuan tidak boleh sama.',
                              ),
                            ),
                          );
                          return;
                        }

                        txnRepo.performTransfer(
                          selectedSourceId!,
                          selectedTargetId!,
                          Decimal.parse(_amountController.text),
                          _descController.text,
                        );

                        // Refresh semua list terkait
                        ref.invalidate(transactionListProvider);
                        ref.invalidate(walletListProvider);
                        ref.invalidate(financialSummaryProvider);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Lakukan Transfer'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
