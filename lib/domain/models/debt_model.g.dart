// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DebtModelImpl _$$DebtModelImplFromJson(Map<String, dynamic> json) =>
    _$DebtModelImpl(
      ledgerId: json['ledger_id'] as String,
      userId: json['user_id'] as String,
      contactName: json['contact_name'] as String,
      phoneNumber: json['phone_number'] as String?,
      isDebtToUser: json['is_debt_to_user'] as bool,
      totalAmount: const DecimalConverter().fromJson(
        json['total_amount'] as Object,
      ),
      amountPaid: const DecimalConverter().fromJson(
        json['amount_paid'] as Object,
      ),
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      isSettled: json['is_settled'] as bool,
    );

Map<String, dynamic> _$$DebtModelImplToJson(_$DebtModelImpl instance) =>
    <String, dynamic>{
      'ledger_id': instance.ledgerId,
      'user_id': instance.userId,
      'contact_name': instance.contactName,
      'phone_number': instance.phoneNumber,
      'is_debt_to_user': instance.isDebtToUser,
      'total_amount': const DecimalConverter().toJson(instance.totalAmount),
      'amount_paid': const DecimalConverter().toJson(instance.amountPaid),
      'due_date': instance.dueDate?.toIso8601String(),
      'is_settled': instance.isSettled,
    };
