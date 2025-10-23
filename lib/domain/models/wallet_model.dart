import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:decimal/decimal.dart'; // Tambahkan dependency decimal

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

@freezed
class WalletModel with _$WalletModel {
  const factory WalletModel({
    @JsonKey(name: 'wallet_id') required String walletId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'wallet_name') required String walletName,
    required String currency,
    @JsonKey(name: 'current_balance')
    @DecimalConverter()
    required Decimal currentBalance,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
}

// Converter untuk Decimal
class DecimalConverter implements JsonConverter<Decimal, Object> {
  const DecimalConverter();

  @override
  Decimal fromJson(Object json) {
    if (json is String) {
      return Decimal.parse(json);
    } else if (json is double) {
      return Decimal.parse(json.toString());
    } else if (json is int) {
      return Decimal.fromInt(json);
    }
    throw FormatException('Invalid format for Decimal: $json');
  }

  @override
  String toJson(Decimal object) => object.toString();
}
