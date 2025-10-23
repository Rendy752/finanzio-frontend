import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:decimal/decimal.dart';
import 'common/decimal_converter.dart';

part 'debt_model.freezed.dart';
part 'debt_model.g.dart';

@freezed
class DebtModel with _$DebtModel {
  const factory DebtModel({
    @JsonKey(name: 'ledger_id') required String ledgerId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'contact_name') required String contactName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'is_debt_to_user')
    required bool isDebtToUser, // True=Piutang, False=Utang
    @JsonKey(name: 'total_amount')
    @DecimalConverter()
    required Decimal totalAmount,
    @JsonKey(name: 'amount_paid')
    @DecimalConverter()
    required Decimal amountPaid,
    @JsonKey(name: 'due_date') DateTime? dueDate,
    @JsonKey(name: 'is_settled') required bool isSettled,
  }) = _DebtModel;

  factory DebtModel.fromJson(Map<String, dynamic> json) =>
      _$DebtModelFromJson(json);
}
