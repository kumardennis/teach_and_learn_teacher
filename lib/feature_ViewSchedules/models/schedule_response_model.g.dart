// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleReponseModel _$ScheduleReponseModelFromJson(
        Map<String, dynamic> json) =>
    ScheduleReponseModel(
      (json['scheduleData'] as List<dynamic>)
          .map((e) => ScheduleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['date'] as String,
    );

Map<String, dynamic> _$ScheduleReponseModelToJson(
        ScheduleReponseModel instance) =>
    <String, dynamic>{
      'scheduleData': instance.scheduleData.map((e) => e.toJson()).toList(),
      'date': instance.date,
    };
