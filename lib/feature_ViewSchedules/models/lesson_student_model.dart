import 'package:json_annotation/json_annotation.dart';

part 'lesson_student_model.g.dart';

@JsonSerializable()
class LessonStudentModel {
  LessonStudentModel(
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
  );

  factory LessonStudentModel.fromJson(Map<String, dynamic> json) =>
      _$LessonStudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonStudentModelToJson(this);

  String id;
  String firstName;
  String lastName;
  String? profileImage;
}
