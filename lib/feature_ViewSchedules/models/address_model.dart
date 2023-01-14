import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressModel {
  AddressModel(
      this.id,
      this.line1,
      this.line2,
      this.city,
      this.stateCountyProvince,
      this.zipCode,
      this.countryName,
      this.countryCode,
      this.geoPoint,
      this.name,
      this.otherDetails);

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  String id;
  String line1;
  String line2;
  String city;
  String stateCountyProvince;
  String zipCode;
  String countryName;
  String countryCode;
  String geoPoint;
  String name;
  String? otherDetails;
}
