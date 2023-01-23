import 'package:json_annotation/json_annotation.dart';
import 'package:teach_and_learn_teacher/shared_models/address_model.dart';

part 'address_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressResponseModel {
  AddressResponseModel(this.Addresses);

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseModelToJson(this);

  AddressModel Addresses;
}
