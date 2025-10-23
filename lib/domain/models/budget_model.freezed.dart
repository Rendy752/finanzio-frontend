// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) {
  return _BudgetModel.fromJson(json);
}

/// @nodoc
mixin _$BudgetModel {
  @JsonKey(name: 'budget_id')
  String get budgetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount_limit')
  @DecimalConverter()
  Decimal get amountLimit => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  DateTime get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Serializes this BudgetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BudgetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetModelCopyWith<BudgetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetModelCopyWith<$Res> {
  factory $BudgetModelCopyWith(
    BudgetModel value,
    $Res Function(BudgetModel) then,
  ) = _$BudgetModelCopyWithImpl<$Res, BudgetModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'budget_id') String budgetId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'amount_limit') @DecimalConverter() Decimal amountLimit,
    @JsonKey(name: 'start_date') DateTime startDate,
    @JsonKey(name: 'end_date') DateTime endDate,
  });
}

/// @nodoc
class _$BudgetModelCopyWithImpl<$Res, $Val extends BudgetModel>
    implements $BudgetModelCopyWith<$Res> {
  _$BudgetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? budgetId = null,
    Object? userId = null,
    Object? categoryId = null,
    Object? amountLimit = freezed,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(
      _value.copyWith(
            budgetId: null == budgetId
                ? _value.budgetId
                : budgetId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            amountLimit: freezed == amountLimit
                ? _value.amountLimit
                : amountLimit // ignore: cast_nullable_to_non_nullable
                      as Decimal,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BudgetModelImplCopyWith<$Res>
    implements $BudgetModelCopyWith<$Res> {
  factory _$$BudgetModelImplCopyWith(
    _$BudgetModelImpl value,
    $Res Function(_$BudgetModelImpl) then,
  ) = __$$BudgetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'budget_id') String budgetId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'amount_limit') @DecimalConverter() Decimal amountLimit,
    @JsonKey(name: 'start_date') DateTime startDate,
    @JsonKey(name: 'end_date') DateTime endDate,
  });
}

/// @nodoc
class __$$BudgetModelImplCopyWithImpl<$Res>
    extends _$BudgetModelCopyWithImpl<$Res, _$BudgetModelImpl>
    implements _$$BudgetModelImplCopyWith<$Res> {
  __$$BudgetModelImplCopyWithImpl(
    _$BudgetModelImpl _value,
    $Res Function(_$BudgetModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BudgetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? budgetId = null,
    Object? userId = null,
    Object? categoryId = null,
    Object? amountLimit = freezed,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(
      _$BudgetModelImpl(
        budgetId: null == budgetId
            ? _value.budgetId
            : budgetId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        amountLimit: freezed == amountLimit
            ? _value.amountLimit
            : amountLimit // ignore: cast_nullable_to_non_nullable
                  as Decimal,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetModelImpl implements _BudgetModel {
  const _$BudgetModelImpl({
    @JsonKey(name: 'budget_id') required this.budgetId,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'amount_limit')
    @DecimalConverter()
    required this.amountLimit,
    @JsonKey(name: 'start_date') required this.startDate,
    @JsonKey(name: 'end_date') required this.endDate,
  });

  factory _$BudgetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetModelImplFromJson(json);

  @override
  @JsonKey(name: 'budget_id')
  final String budgetId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'category_id')
  final String categoryId;
  @override
  @JsonKey(name: 'amount_limit')
  @DecimalConverter()
  final Decimal amountLimit;
  @override
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @override
  @JsonKey(name: 'end_date')
  final DateTime endDate;

  @override
  String toString() {
    return 'BudgetModel(budgetId: $budgetId, userId: $userId, categoryId: $categoryId, amountLimit: $amountLimit, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetModelImpl &&
            (identical(other.budgetId, budgetId) ||
                other.budgetId == budgetId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            const DeepCollectionEquality().equals(
              other.amountLimit,
              amountLimit,
            ) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    budgetId,
    userId,
    categoryId,
    const DeepCollectionEquality().hash(amountLimit),
    startDate,
    endDate,
  );

  /// Create a copy of BudgetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetModelImplCopyWith<_$BudgetModelImpl> get copyWith =>
      __$$BudgetModelImplCopyWithImpl<_$BudgetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetModelImplToJson(this);
  }
}

abstract class _BudgetModel implements BudgetModel {
  const factory _BudgetModel({
    @JsonKey(name: 'budget_id') required final String budgetId,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'category_id') required final String categoryId,
    @JsonKey(name: 'amount_limit')
    @DecimalConverter()
    required final Decimal amountLimit,
    @JsonKey(name: 'start_date') required final DateTime startDate,
    @JsonKey(name: 'end_date') required final DateTime endDate,
  }) = _$BudgetModelImpl;

  factory _BudgetModel.fromJson(Map<String, dynamic> json) =
      _$BudgetModelImpl.fromJson;

  @override
  @JsonKey(name: 'budget_id')
  String get budgetId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'category_id')
  String get categoryId;
  @override
  @JsonKey(name: 'amount_limit')
  @DecimalConverter()
  Decimal get amountLimit;
  @override
  @JsonKey(name: 'start_date')
  DateTime get startDate;
  @override
  @JsonKey(name: 'end_date')
  DateTime get endDate;

  /// Create a copy of BudgetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetModelImplCopyWith<_$BudgetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
