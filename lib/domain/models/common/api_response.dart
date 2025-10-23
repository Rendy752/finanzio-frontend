import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

// Model untuk respons API tunggal (misalnya POST/GET single item)
@Freezed(genericArgumentFactories: true)
class APIResponse<T> with _$APIResponse<T> {
  const factory APIResponse({
    @Default(true) bool success,
    @Default('Request successful') String message,
    required T data,
  }) = _APIResponse;

  factory APIResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$APIResponseFromJson(json, fromJsonT);
}

// Model untuk respons API daftar (misalnya GET all items)
@Freezed(genericArgumentFactories: true)
class APIListResponse<T> with _$APIListResponse<T> {
  const factory APIListResponse({
    @Default(true) bool success,
    @Default('Request successful') String message,
    @Default(0) @JsonKey(name: 'total_count') int totalCount,
    required List<T> data,
  }) = _APIListResponse;

  factory APIListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$APIListResponseFromJson(json, fromJsonT);
}
