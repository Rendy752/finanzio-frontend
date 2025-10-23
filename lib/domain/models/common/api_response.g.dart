// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$APIResponseImpl<T> _$$APIResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$APIResponseImpl<T>(
  success: json['success'] as bool? ?? true,
  message: json['message'] as String? ?? 'Request successful',
  data: fromJsonT(json['data']),
);

Map<String, dynamic> _$$APIResponseImplToJson<T>(
  _$APIResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': toJsonT(instance.data),
};

_$APIListResponseImpl<T> _$$APIListResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$APIListResponseImpl<T>(
  success: json['success'] as bool? ?? true,
  message: json['message'] as String? ?? 'Request successful',
  totalCount: (json['total_count'] as num?)?.toInt() ?? 0,
  data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
);

Map<String, dynamic> _$$APIListResponseImplToJson<T>(
  _$APIListResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'total_count': instance.totalCount,
  'data': instance.data.map(toJsonT).toList(),
};
