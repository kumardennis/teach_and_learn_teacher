import 'package:json_annotation/json_annotation.dart';

part 'subcategory_model.g.dart';

@JsonSerializable()
class SubcategoryModel {
  SubcategoryModel(
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.picture,
  );

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryModelToJson(this);

  String id;
  String categoryId;
  String name;
  String description;
  String picture;
}
