import 'package:decimal/decimal.dart';
import 'package:finanzio/domain/models/category_model.dart';
import 'package:flutter/foundation.dart';

// --- Wallet Input ---
@immutable
class WalletInput {
  final String name;
  final String currency;
  final Decimal initialBalance;

  const WalletInput({
    required this.name,
    required this.currency,
    required this.initialBalance,
  });
}

// --- Transaction Input ---
@immutable
class TransactionInput {
  final String walletId;
  final String categoryId;
  final TransactionType type;
  final Decimal amount;
  final String description;

  const TransactionInput({
    required this.walletId,
    required this.categoryId,
    required this.type,
    required this.amount,
    required this.description,
  });
}

// --- Transfer Input ---
@immutable
class TransferInput {
  final String sourceWalletId;
  final String targetWalletId;
  final Decimal amount;
  final String description;

  const TransferInput({
    required this.sourceWalletId,
    required this.targetWalletId,
    required this.amount,
    required this.description,
  });
}
