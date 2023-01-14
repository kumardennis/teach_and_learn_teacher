// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
      json['id'] as String,
      (json['fee'] as num).toDouble(),
      json['studentComment'] as String?,
      json['teacherComment'] as String?,
      json['studentRating'] as int?,
      json['teacherRating'] as int?,
      json['studentSkillLevelRating'] as int?,
      json['hasLessonEnded'] as bool?,
      json['hasLessonEndedEarly'] as bool?,
      json['hasLessonStarted'] as bool?,
      json['isInWaitingList'] as bool?,
      json['isAccepted'] as bool?,
      json['isChild'] as bool?,
      json['Addresses'] == null
          ? null
          : AddressModel.fromJson(json['Addresses'] as Map<String, dynamic>),
      json['Students'] == null
          ? null
          : LessonStudentModel.fromJson(
              json['Students'] as Map<String, dynamic>),
      (json['Lessons_LessonScheduleTimes'] as List<dynamic>?)
          ?.map((e) => Lesson_LessonScheduleTimeModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fee': instance.fee,
      'studentComment': instance.studentComment,
      'teacherComment': instance.teacherComment,
      'studentRating': instance.studentRating,
      'teacherRating': instance.teacherRating,
      'studentSkillLevelRating': instance.studentSkillLevelRating,
      'hasLessonEnded': instance.hasLessonEnded,
      'hasLessonEndedEarly': instance.hasLessonEndedEarly,
      'hasLessonStarted': instance.hasLessonStarted,
      'isInWaitingList': instance.isInWaitingList,
      'isAccepted': instance.isAccepted,
      'isChild': instance.isChild,
      'Addresses': instance.Addresses?.toJson(),
      'Students': instance.Students?.toJson(),
      'Lessons_LessonScheduleTimes':
          instance.Lessons_LessonScheduleTimes?.map((e) => e.toJson()).toList(),
    };
