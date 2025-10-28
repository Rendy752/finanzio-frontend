// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FinancialSummaryModel _$FinancialSummaryModelFromJson(
  Map<String, dynamic> json,
) {
  return _FinancialSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$FinancialSummaryModel {
  @JsonKey(name: 'total_income')
  @DecimalConverter()
  Decimal get totalIncome => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_expense')
  @DecimalConverter()
  Decimal get totalExpense => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_balance')
  @DecimalConverter()
  Decimal get netBalance => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_generated')
  DateTime get dateGenerated => throw _privateConstructorUsedError;

  /// Serializes this FinancialSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FinancialSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FinancialSummaryModelCopyWith<FinancialSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialSummaryModelCopyWith<$Res> {
  factory $FinancialSummaryModelCopyWith(
    FinancialSummaryModel value,
    $Res Function(FinancialSummaryModel) then,
  ) = _$FinancialSummaryModelCopyWithImpl<$Res, FinancialSummaryModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_income') @DecimalConverter() Decimal totalIncome,
    @JsonKey(name: 'total_expense') @DecimalConverter() Decimal totalExpense,
    @JsonKey(name: 'net_balance') @DecimalConverter() Decimal netBalance,
    @JsonKey(name: 'date_generated') DateTime dateGenerated,
  });
}

/// @nodoc
class _$FinancialSummaryModelCopyWithImpl<
  $Res,
  $Val extends FinancialSummaryModel
>
    implements $FinancialSummaryModelCopyWith<$Res> {
  _$FinancialSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FinancialSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncome = null,
    Object? totalExpense = null,
    Object? netBalance = null,
    Object? dateGenerated = null,
  }) {
    return _then(
      _value.copyWith(
            totalIncome: null == totalIncome
                ? _value.totalIncome
                : totalIncome // ignore: cast_nullable_to_non_nullable
                      as Decimal,
            totalExpense: null == totalExpense
                ? _value.totalExpense
                : totalExpense // ignore: cast_nullable_to_non_nullable
                      as Decimal,
            netBalance: null == netBalance
                ? _value.netBalance
                : netBalance // ignore: cast_nullable_to_non_nullable
                      as Decimal,
            dateGenerated: null == dateGenerated
                ? _value.dateGenerated
                : dateGenerated // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FinancialSummaryModelImplCopyWith<$Res>
    implements $FinancialSummaryModelCopyWith<$Res> {
  factory _$$FinancialSummaryModelImplCopyWith(
    _$FinancialSummaryModelImpl value,
    $Res Function(_$FinancialSummaryModelImpl) then,
  ) = __$$FinancialSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_income') @DecimalConverter() Decimal totalIncome,
    @JsonKey(name: 'total_expense') @DecimalConverter() Decimal totalExpense,
    @JsonKey(name: 'net_balance') @DecimalConverter() Decimal netBalance,
    @JsonKey(name: 'date_generated') DateTime dateGenerated,
  });
}

/// @nodoc
class __$$FinancialSummaryModelImplCopyWithImpl<$Res>
    extends
        _$FinancialSummaryModelCopyWithImpl<$Res, _$FinancialSummaryModelImpl>
    implements _$$FinancialSummaryModelImplCopyWith<$Res> {
  __$$FinancialSummaryModelImplCopyWithImpl(
    _$FinancialSummaryModelImpl _value,
    $Res Function(_$FinancialSummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FinancialSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncome = null,
    Object? totalExpense = null,
    Object? netBalance = null,
    Object? dateGenerated = null,
  }) {
    return _then(
      _$FinancialSummaryModelImpl(
        totalIncome: null == totalIncome
            ? _value.totalIncome
            : totalIncome // ignore: cast_nullable_to_non_nullable
                  as Decimal,
        totalExpense: null == totalExpense
            ? _value.totalExpense
            : totalExpense // ignore: cast_nullable_to_non_nullable
                  as Decimal,
        netBalance: null == netBalance
            ? _value.netBalance
            : netBalance // ignore: cast_nullable_to_non_nullable
                  as Decimal,
        dateGenerated: null == dateGenerated
            ? _value.dateGenerated
            : dateGenerated // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialSummaryModelImpl implements _FinancialSummaryModel {
  const _$FinancialSummaryModelImpl({
    @JsonKey(name: 'total_income')
    @DecimalConverter()
    required this.totalIncome,
    @JsonKey(name: 'total_expense')
    @DecimalConverter()
    required this.totalExpense,
    @JsonKey(name: 'net_balance') @DecimalConverter() required this.netBalance,
    @JsonKey(name: 'date_generated') required this.dateGenerated,
  });

  factory _$FinancialSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_income')
  @DecimalConverter()
  final Decimal totalIncome;
  @override
  @JsonKey(name: 'total_expense')
  @DecimalConverter()
  final Decimal totalExpense;
  @override
  @JsonKey(name: 'net_balance')
  @DecimalConverter()
  final Decimal netBalance;
  @override
  @JsonKey(name: 'date_generated')
  final DateTime dateGenerated;

  @override
  String toString() {
    return 'FinancialSummaryModel(totalIncome: $totalIncome, totalExpense: $totalExpense, netBalance: $netBalance, dateGenerated: $dateGenerated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialSummaryModelImpl &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.totalExpense, totalExpense) ||
                other.totalExpense == totalExpense) &&
            (identical(other.netBalance, netBalance) ||
                other.netBalance == netBalance) &&
            (identical(other.dateGenerated, dateGenerated) ||
                other.dateGenerated == dateGenerated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalIncome,
    totalExpense,
    netBalance,
    dateGenerated,
  );

  /// Create a copy of FinancialSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialSummaryModelImplCopyWith<_$FinancialSummaryModelImpl>
  get copyWith =>
      __$$FinancialSummaryModelImplCopyWithImpl<_$FinancialSummaryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FinancialSummaryModelImplToJson(this);
  }
}

abstract class _FinancialSummaryModel implements FinancialSummaryModel {
  const factory _FinancialSummaryModel({
    @JsonKey(name: 'total_income')
    @DecimalConverter()
    required final Decimal totalIncome,
    @JsonKey(name: 'total_expense')
    @DecimalConverter()
    required final Decimal totalExpense,
    @JsonKey(name: 'net_balance')
    @DecimalConverter()
    required final Decimal netBalance,
    @JsonKey(name: 'date_generated') required final DateTime dateGenerated,
  }) = _$FinancialSummaryModelImpl;

  factory _FinancialSummaryModel.fromJson(Map<String, dynamic> json) =
      _$FinancialSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_income')
  @DecimalConverter()
  Decimal get totalIncome;
  @override
  @JsonKey(name: 'total_expense')
  @DecimalConverter()
  Decimal get totalExpense;
  @override
  @JsonKey(name: 'net_balance')
  @DecimalConverter()
  Decimal get netBalance;
  @override
  @JsonKey(name: 'date_generated')
  DateTime get dateGenerated;

  /// Create a copy of FinancialSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FinancialSummaryModelImplCopyWith<_$FinancialSummaryModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
