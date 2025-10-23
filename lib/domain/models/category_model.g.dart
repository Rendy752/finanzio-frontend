// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryModelImpl _$$CategoryModelImplFromJson(Map<String, dynamic> json) =>
    _$CategoryModelImpl(
      categoryId: json['category_id'] as String,
      categoryName: json['category_name'] as String,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$CategoryModelImplToJson(_$CategoryModelImpl instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'type': _$TransactionTypeEnumMap[instance.type]!,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'INCOME',
  TransactionType.expense: 'EXPENSE',
};
