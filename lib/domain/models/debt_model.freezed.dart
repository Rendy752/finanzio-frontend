// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DebtModel _$DebtModelFromJson(Map<String, dynamic> json) {
  return _DebtModel.fromJson(json);
}

/// @nodoc
mixin _$DebtModel {
  @JsonKey(name: 'ledger_id')
  String get ledgerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_name')
  String get contactName => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String? get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_debt_to_user')
  bool get isDebtToUser => throw _privateConstructorUsedError; // True=Piutang, False=Utang
  @JsonKey(name: 'total_amount')
  @DecimalConverter()
  Decimal get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount_paid')
  @DecimalConverter()
  Decimal get amountPaid => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_date')
  DateTime? get dueDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_settled')
  bool get isSettled => throw _privateConstructorUsedError;

  /// Serializes this DebtModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DebtModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DebtModelCopyWith<DebtModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebtModelCopyWith<$Res> {
  factory $DebtModelCopyWith(DebtModel value, $Res Function(DebtModel) then) =
      _$DebtModelCopyWithImpl<$Res, DebtModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'ledger_id') String ledgerId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'contact_name') String contactName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'is_debt_to_user') bool isDebtToUser,
    @JsonKey(name: 'total_amount') @DecimalConverter() Decimal totalAmount,
    @JsonKey(name: 'amount_paid') @DecimalConverter() Decimal amountPaid,
    @JsonKey(name: 'due_date') DateTime? dueDate,
    @JsonKey(name: 'is_settled') bool isSettled,
  });
}

/// @nodoc
class _$DebtModelCopyWithImpl<$Res, $Val extends DebtModel>
    implements $DebtModelCopyWith<$Res> {
  _$DebtModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DebtModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ledgerId = null,
    Object? userId = null,
    Object? contactName = null,
    Object? phoneNumber = freezed,
    Object? isDebtToUser = null,
    Object? totalAmount = null,
    Object? amountPaid = null,
    Object? dueDate = freezed,
    Object? isSettled = null,
  }) {
    return _then(
      _value.copyWith(
            ledgerId: null == ledgerId
                ? _value.ledgerId
                : ledgerId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            contactName: null == contactName
                ? _value.contactName
                : contactName // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDebtToUser: null == isDebtToUser
                ? _value.isDebtToUser
                : isDebtToUser // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as Decimal,
            amountPaid: null == amountPaid
                ? _value.amountPaid
                : amountPaid // ignore: cast_nullable_to_non_nullable
                      as Decimal,
            dueDate: freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isSettled: null == isSettled
                ? _value.isSettled
                : isSettled // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DebtModelImplCopyWith<$Res>
    implements $DebtModelCopyWith<$Res> {
  factory _$$DebtModelImplCopyWith(
    _$DebtModelImpl value,
    $Res Function(_$DebtModelImpl) then,
  ) = __$$DebtModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ledger_id') String ledgerId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'contact_name') String contactName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'is_debt_to_user') bool isDebtToUser,
    @JsonKey(name: 'total_amount') @DecimalConverter() Decimal totalAmount,
    @JsonKey(name: 'amount_paid') @DecimalConverter() Decimal amountPaid,
    @JsonKey(name: 'due_date') DateTime? dueDate,
    @JsonKey(name: 'is_settled') bool isSettled,
  });
}

/// @nodoc
class __$$DebtModelImplCopyWithImpl<$Res>
    extends _$DebtModelCopyWithImpl<$Res, _$DebtModelImpl>
    implements _$$DebtModelImplCopyWith<$Res> {
  __$$DebtModelImplCopyWithImpl(
    _$DebtModelImpl _value,
    $Res Function(_$DebtModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DebtModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ledgerId = null,
    Object? userId = null,
    Object? contactName = null,
    Object? phoneNumber = freezed,
    Object? isDebtToUser = null,
    Object? totalAmount = null,
    Object? amountPaid = null,
    Object? dueDate = freezed,
    Object? isSettled = null,
  }) {
    return _then(
      _$DebtModelImpl(
        ledgerId: null == ledgerId
            ? _value.ledgerId
            : ledgerId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        contactName: null == contactName
            ? _value.contactName
            : contactName // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDebtToUser: null == isDebtToUser
            ? _value.isDebtToUser
            : isDebtToUser // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as Decimal,
        amountPaid: null == amountPaid
            ? _value.amountPaid
            : amountPaid // ignore: cast_nullable_to_non_nullable
                  as Decimal,
        dueDate: freezed == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isSettled: null == isSettled
            ? _value.isSettled
            : isSettled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DebtModelImpl implements _DebtModel {
  const _$DebtModelImpl({
    @JsonKey(name: 'ledger_id') required this.ledgerId,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'contact_name') required this.contactName,
    @JsonKey(name: 'phone_number') this.phoneNumber,
    @JsonKey(name: 'is_debt_to_user') required this.isDebtToUser,
    @JsonKey(name: 'total_amount')
    @DecimalConverter()
    required this.totalAmount,
    @JsonKey(name: 'amount_paid') @DecimalConverter() required this.amountPaid,
    @JsonKey(name: 'due_date') this.dueDate,
    @JsonKey(name: 'is_settled') required this.isSettled,
  });

  factory _$DebtModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DebtModelImplFromJson(json);

  @override
  @JsonKey(name: 'ledger_id')
  final String ledgerId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'contact_name')
  final String contactName;
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @override
  @JsonKey(name: 'is_debt_to_user')
  final bool isDebtToUser;
  // True=Piutang, False=Utang
  @override
  @JsonKey(name: 'total_amount')
  @DecimalConverter()
  final Decimal totalAmount;
  @override
  @JsonKey(name: 'amount_paid')
  @DecimalConverter()
  final Decimal amountPaid;
  @override
  @JsonKey(name: 'due_date')
  final DateTime? dueDate;
  @override
  @JsonKey(name: 'is_settled')
  final bool isSettled;

  @override
  String toString() {
    return 'DebtModel(ledgerId: $ledgerId, userId: $userId, contactName: $contactName, phoneNumber: $phoneNumber, isDebtToUser: $isDebtToUser, totalAmount: $totalAmount, amountPaid: $amountPaid, dueDate: $dueDate, isSettled: $isSettled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebtModelImpl &&
            (identical(other.ledgerId, ledgerId) ||
                other.ledgerId == ledgerId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isDebtToUser, isDebtToUser) ||
                other.isDebtToUser == isDebtToUser) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.amountPaid, amountPaid) ||
                other.amountPaid == amountPaid) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.isSettled, isSettled) ||
                other.isSettled == isSettled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    ledgerId,
    userId,
    contactName,
    phoneNumber,
    isDebtToUser,
    totalAmount,
    amountPaid,
    dueDate,
    isSettled,
  );

  /// Create a copy of DebtModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DebtModelImplCopyWith<_$DebtModelImpl> get copyWith =>
      __$$DebtModelImplCopyWithImpl<_$DebtModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DebtModelImplToJson(this);
  }
}

abstract class _DebtModel implements DebtModel {
  const factory _DebtModel({
    @JsonKey(name: 'ledger_id') required final String ledgerId,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'contact_name') required final String contactName,
    @JsonKey(name: 'phone_number') final String? phoneNumber,
    @JsonKey(name: 'is_debt_to_user') required final bool isDebtToUser,
    @JsonKey(name: 'total_amount')
    @DecimalConverter()
    required final Decimal totalAmount,
    @JsonKey(name: 'amount_paid')
    @DecimalConverter()
    required final Decimal amountPaid,
    @JsonKey(name: 'due_date') final DateTime? dueDate,
    @JsonKey(name: 'is_settled') required final bool isSettled,
  }) = _$DebtModelImpl;

  factory _DebtModel.fromJson(Map<String, dynamic> json) =
      _$DebtModelImpl.fromJson;

  @override
  @JsonKey(name: 'ledger_id')
  String get ledgerId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'contact_name')
  String get contactName;
  @override
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;
  @override
  @JsonKey(name: 'is_debt_to_user')
  bool get isDebtToUser; // True=Piutang, False=Utang
  @override
  @JsonKey(name: 'total_amount')
  @DecimalConverter()
  Decimal get totalAmount;
  @override
  @JsonKey(name: 'amount_paid')
  @DecimalConverter()
  Decimal get amountPaid;
  @override
  @JsonKey(name: 'due_date')
  DateTime? get dueDate;
  @override
  @JsonKey(name: 'is_settled')
  bool get isSettled;

  /// Create a copy of DebtModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DebtModelImplCopyWith<_$DebtModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
