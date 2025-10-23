import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:decimal/decimal.dart';
import 'common/decimal_converter.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class FinancialSummaryModel with _$FinancialSummaryModel {
  const factory FinancialSummaryModel({
    @JsonKey(name: 'total_income')
    @DecimalConverter()
    required Decimal totalIncome,
    @JsonKey(name: 'total_expense')
    @DecimalConverter()
    required Decimal totalExpense,
    @JsonKey(name: 'net_balance')
    @DecimalConverter()
    required Decimal netBalance,
    @JsonKey(name: 'date_generated') required DateTime dateGenerated,
  }) = _FinancialSummaryModel;

  factory FinancialSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$FinancialSummaryModelFromJson(json);
}
