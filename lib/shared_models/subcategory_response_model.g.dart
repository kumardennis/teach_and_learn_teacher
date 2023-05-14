// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubcategoryResponseModel _$SubcategoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    SubcategoryResponseModel(
      SubcategoryModel.fromJson(json['Subcategories'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubcategoryResponseModelToJson(
        SubcategoryResponseModel instance) =>
    <String, dynamic>{
      'Subcateogories': instance.Subcategories.toJson(),
    };
