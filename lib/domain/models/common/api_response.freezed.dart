// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

APIResponse<T> _$APIResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _APIResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$APIResponse<T> {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  T get data => throw _privateConstructorUsedError;

  /// Serializes this APIResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of APIResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $APIResponseCopyWith<T, APIResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $APIResponseCopyWith<T, $Res> {
  factory $APIResponseCopyWith(
    APIResponse<T> value,
    $Res Function(APIResponse<T>) then,
  ) = _$APIResponseCopyWithImpl<T, $Res, APIResponse<T>>;
  @useResult
  $Res call({bool success, String message, T data});
}

/// @nodoc
class _$APIResponseCopyWithImpl<T, $Res, $Val extends APIResponse<T>>
    implements $APIResponseCopyWith<T, $Res> {
  _$APIResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of APIResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as T,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$APIResponseImplCopyWith<T, $Res>
    implements $APIResponseCopyWith<T, $Res> {
  factory _$$APIResponseImplCopyWith(
    _$APIResponseImpl<T> value,
    $Res Function(_$APIResponseImpl<T>) then,
  ) = __$$APIResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({bool success, String message, T data});
}

/// @nodoc
class __$$APIResponseImplCopyWithImpl<T, $Res>
    extends _$APIResponseCopyWithImpl<T, $Res, _$APIResponseImpl<T>>
    implements _$$APIResponseImplCopyWith<T, $Res> {
  __$$APIResponseImplCopyWithImpl(
    _$APIResponseImpl<T> _value,
    $Res Function(_$APIResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of APIResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _$APIResponseImpl<T>(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$APIResponseImpl<T> implements _APIResponse<T> {
  const _$APIResponseImpl({
    this.success = true,
    this.message = 'Request successful',
    required this.data,
  });

  factory _$APIResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$APIResponseImplFromJson(json, fromJsonT);

  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey()
  final String message;
  @override
  final T data;

  @override
  String toString() {
    return 'APIResponse<$T>(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$APIResponseImpl<T> &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    message,
    const DeepCollectionEquality().hash(data),
  );

  /// Create a copy of APIResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$APIResponseImplCopyWith<T, _$APIResponseImpl<T>> get copyWith =>
      __$$APIResponseImplCopyWithImpl<T, _$APIResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$APIResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _APIResponse<T> implements APIResponse<T> {
  const factory _APIResponse({
    final bool success,
    final String message,
    required final T data,
  }) = _$APIResponseImpl<T>;

  factory _APIResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$APIResponseImpl<T>.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  T get data;

  /// Create a copy of APIResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$APIResponseImplCopyWith<T, _$APIResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

APIListResponse<T> _$APIListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _APIListResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$APIListResponse<T> {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_count')
  int get totalCount => throw _privateConstructorUsedError;
  List<T> get data => throw _privateConstructorUsedError;

  /// Serializes this APIListResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of APIListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $APIListResponseCopyWith<T, APIListResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $APIListResponseCopyWith<T, $Res> {
  factory $APIListResponseCopyWith(
    APIListResponse<T> value,
    $Res Function(APIListResponse<T>) then,
  ) = _$APIListResponseCopyWithImpl<T, $Res, APIListResponse<T>>;
  @useResult
  $Res call({
    bool success,
    String message,
    @JsonKey(name: 'total_count') int totalCount,
    List<T> data,
  });
}

/// @nodoc
class _$APIListResponseCopyWithImpl<T, $Res, $Val extends APIListResponse<T>>
    implements $APIListResponseCopyWith<T, $Res> {
  _$APIListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of APIListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? totalCount = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<T>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$APIListResponseImplCopyWith<T, $Res>
    implements $APIListResponseCopyWith<T, $Res> {
  factory _$$APIListResponseImplCopyWith(
    _$APIListResponseImpl<T> value,
    $Res Function(_$APIListResponseImpl<T>) then,
  ) = __$$APIListResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    bool success,
    String message,
    @JsonKey(name: 'total_count') int totalCount,
    List<T> data,
  });
}

/// @nodoc
class __$$APIListResponseImplCopyWithImpl<T, $Res>
    extends _$APIListResponseCopyWithImpl<T, $Res, _$APIListResponseImpl<T>>
    implements _$$APIListResponseImplCopyWith<T, $Res> {
  __$$APIListResponseImplCopyWithImpl(
    _$APIListResponseImpl<T> _value,
    $Res Function(_$APIListResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of APIListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? totalCount = null,
    Object? data = null,
  }) {
    return _then(
      _$APIListResponseImpl<T>(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<T>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$APIListResponseImpl<T> implements _APIListResponse<T> {
  const _$APIListResponseImpl({
    this.success = true,
    this.message = 'Request successful',
    @JsonKey(name: 'total_count') this.totalCount = 0,
    required final List<T> data,
  }) : _data = data;

  factory _$APIListResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$APIListResponseImplFromJson(json, fromJsonT);

  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey(name: 'total_count')
  final int totalCount;
  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'APIListResponse<$T>(success: $success, message: $message, totalCount: $totalCount, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$APIListResponseImpl<T> &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    message,
    totalCount,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of APIListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$APIListResponseImplCopyWith<T, _$APIListResponseImpl<T>> get copyWith =>
      __$$APIListResponseImplCopyWithImpl<T, _$APIListResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$APIListResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _APIListResponse<T> implements APIListResponse<T> {
  const factory _APIListResponse({
    final bool success,
    final String message,
    @JsonKey(name: 'total_count') final int totalCount,
    required final List<T> data,
  }) = _$APIListResponseImpl<T>;

  factory _APIListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$APIListResponseImpl<T>.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  @JsonKey(name: 'total_count')
  int get totalCount;
  @override
  List<T> get data;

  /// Create a copy of APIListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$APIListResponseImplCopyWith<T, _$APIListResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
