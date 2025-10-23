// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BudgetModelImpl _$$BudgetModelImplFromJson(Map<String, dynamic> json) =>
    _$BudgetModelImpl(
      budgetId: json['budget_id'] as String,
      userId: json['user_id'] as String,
      categoryId: json['category_id'] as String,
      amountLimit: const DecimalConverter().fromJson(
        json['amount_limit'] as Object,
      ),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$$BudgetModelImplToJson(_$BudgetModelImpl instance) =>
    <String, dynamic>{
      'budget_id': instance.budgetId,
      'user_id': instance.userId,
      'category_id': instance.categoryId,
      'amount_limit': const DecimalConverter().toJson(instance.amountLimit),
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
    };
