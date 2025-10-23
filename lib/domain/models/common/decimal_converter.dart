import 'package:json_annotation/json_annotation.dart';
import 'package:decimal/decimal.dart';

class DecimalConverter implements JsonConverter<Decimal, Object> {
  const DecimalConverter();

  @override
  Decimal fromJson(Object json) {
    if (json is String) {
      return Decimal.parse(json);
    } else if (json is double) {
      // Perlu konversi ke string dulu untuk presisi Decimal
      return Decimal.parse(json.toString());
    } else if (json is int) {
      return Decimal.fromInt(json);
    }
    throw FormatException('Invalid format for Decimal: $json');
  }

  @override
  String toJson(Decimal object) => object.toString();
}
