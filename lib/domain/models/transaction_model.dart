import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:decimal/decimal.dart';
import 'common/decimal_converter.dart';
import 'category_model.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    @JsonKey(name: 'transaction_id') required String transactionId,
    @JsonKey(name: 'wallet_id') required String walletId,
    @JsonKey(name: 'category_id') required String categoryId,
    @JsonKey(name: 'transaction_type') required TransactionType transactionType,
    @DecimalConverter() required Decimal amount,
    required String description,
    @JsonKey(name: 'transaction_date') required DateTime transactionDate,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
