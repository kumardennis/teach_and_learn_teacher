// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_schedule_times_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonScheduleTimesModel _$LessonScheduleTimesModelFromJson(
        Map<String, dynamic> json) =>
    LessonScheduleTimesModel(
      json['scheduleId'] as String,
      json['time'] as String,
      json['isBooked'] as bool?,
      json['id'] as String,
    );

Map<String, dynamic> _$LessonScheduleTimesModelToJson(
        LessonScheduleTimesModel instance) =>
    <String, dynamic>{
      'scheduleId': instance.scheduleId,
      'time': instance.time,
      'isBooked': instance.isBooked,
      'id': instance.id,
    };
