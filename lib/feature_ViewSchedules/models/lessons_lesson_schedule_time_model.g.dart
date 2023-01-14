// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessons_lesson_schedule_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson_LessonScheduleTimeModel _$Lesson_LessonScheduleTimeModelFromJson(
        Map<String, dynamic> json) =>
    Lesson_LessonScheduleTimeModel(
      LessonScheduleTimesModel.fromJson(
          json['LessonScheduleTimes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Lesson_LessonScheduleTimeModelToJson(
        Lesson_LessonScheduleTimeModel instance) =>
    <String, dynamic>{
      'LessonScheduleTimes': instance.LessonScheduleTimes.toJson(),
    };
