// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FinancialSummaryModelImpl _$$FinancialSummaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$FinancialSummaryModelImpl(
  totalIncome: const DecimalConverter().fromJson(
    json['total_income'] as Object,
  ),
  totalExpense: const DecimalConverter().fromJson(
    json['total_expense'] as Object,
  ),
  netBalance: const DecimalConverter().fromJson(json['net_balance'] as Object),
  dateGenerated: DateTime.parse(json['date_generated'] as String),
);

Map<String, dynamic> _$$FinancialSummaryModelImplToJson(
  _$FinancialSummaryModelImpl instance,
) => <String, dynamic>{
  'total_income': const DecimalConverter().toJson(instance.totalIncome),
  'total_expense': const DecimalConverter().toJson(instance.totalExpense),
  'net_balance': const DecimalConverter().toJson(instance.netBalance),
  'date_generated': instance.dateGenerated.toIso8601String(),
};
