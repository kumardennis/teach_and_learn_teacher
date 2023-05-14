import 'package:json_annotation/json_annotation.dart';
import 'package:teach_and_learn_teacher/shared_models/address_model.dart';
import 'package:teach_and_learn_teacher/shared_models/subcategory_model.dart';

part 'subcategory_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SubcategoryResponseModel {
  SubcategoryResponseModel(this.Subcategories);

  factory SubcategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryResponseModelToJson(this);

  SubcategoryModel Subcategories;
}
