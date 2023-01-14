// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonStudentModel _$LessonStudentModelFromJson(Map<String, dynamic> json) =>
    LessonStudentModel(
      json['id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['profileImage'] as String?,
    );

Map<String, dynamic> _$LessonStudentModelToJson(LessonStudentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profileImage': instance.profileImage,
    };
