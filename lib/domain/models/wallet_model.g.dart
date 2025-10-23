// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletModelImpl _$$WalletModelImplFromJson(Map<String, dynamic> json) =>
    _$WalletModelImpl(
      walletId: json['wallet_id'] as String,
      userId: json['user_id'] as String,
      walletName: json['wallet_name'] as String,
      currency: json['currency'] as String,
      currentBalance: const DecimalConverter().fromJson(
        json['current_balance'] as Object,
      ),
    );

Map<String, dynamic> _$$WalletModelImplToJson(
  _$WalletModelImpl instance,
) => <String, dynamic>{
  'wallet_id': instance.walletId,
  'user_id': instance.userId,
  'wallet_name': instance.walletName,
  'currency': instance.currency,
  'current_balance': const DecimalConverter().toJson(instance.currentBalance),
};
