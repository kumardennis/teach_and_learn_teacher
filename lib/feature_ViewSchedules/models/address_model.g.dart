// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      json['id'] as String,
      json['line1'] as String,
      json['line2'] as String,
      json['city'] as String,
      json['stateCountyProvince'] as String,
      json['zipCode'] as String,
      json['countryName'] as String,
      json['countryCode'] as String,
      json['geoPoint'] as String,
      json['name'] as String,
      json['otherDetails'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'line1': instance.line1,
      'line2': instance.line2,
      'city': instance.city,
      'stateCountyProvince': instance.stateCountyProvince,
      'zipCode': instance.zipCode,
      'countryName': instance.countryName,
      'countryCode': instance.countryCode,
      'geoPoint': instance.geoPoint,
      'name': instance.name,
      'otherDetails': instance.otherDetails,
    };
