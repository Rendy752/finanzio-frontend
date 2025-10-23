// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionModelImpl(
  transactionId: json['transaction_id'] as String,
  walletId: json['wallet_id'] as String,
  categoryId: json['category_id'] as String,
  transactionType: $enumDecode(
    _$TransactionTypeEnumMap,
    json['transaction_type'],
  ),
  amount: const DecimalConverter().fromJson(json['amount'] as Object),
  description: json['description'] as String,
  transactionDate: DateTime.parse(json['transaction_date'] as String),
);

Map<String, dynamic> _$$TransactionModelImplToJson(
  _$TransactionModelImpl instance,
) => <String, dynamic>{
  'transaction_id': instance.transactionId,
  'wallet_id': instance.walletId,
  'category_id': instance.categoryId,
  'transaction_type': _$TransactionTypeEnumMap[instance.transactionType]!,
  'amount': const DecimalConverter().toJson(instance.amount),
  'description': instance.description,
  'transaction_date': instance.transactionDate.toIso8601String(),
};

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'INCOME',
  TransactionType.expense: 'EXPENSE',
};
