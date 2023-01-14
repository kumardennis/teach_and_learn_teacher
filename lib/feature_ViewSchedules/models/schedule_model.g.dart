// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      json['id'] as String,
      json['created_at'] as String,
      json['scheduleTimeStart'] as String,
      json['scheduleDate'] as String,
      json['isBooked'] as bool?,
      json['teacherId'] as String,
      json['maxOccupancy'] as int,
      json['subcategoryId'] as String,
      json['isRegularGroup'] as bool?,
      json['groupId'] as String?,
      json['canBeSeenBy'] as String,
      json['durationInMins'] as int?,
      (json['feeForTheLesson'] as num?)?.toDouble(),
      (json['feePerOccupant'] as num?)?.toDouble(),
      (json['lateCancellationPenalty'] as num?)?.toDouble(),
      json['levelFrom'] as int,
      json['levelUpto'] as int,
      json['autoAddWaitingStudents'] as bool?,
      json['scheduleTimeEnd'] as String,
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at,
      'scheduleTimeStart': instance.scheduleTimeStart,
      'scheduleDate': instance.scheduleDate,
      'isBooked': instance.isBooked,
      'teacherId': instance.teacherId,
      'maxOccupancy': instance.maxOccupancy,
      'subcategoryId': instance.subcategoryId,
      'isRegularGroup': instance.isRegularGroup,
      'groupId': instance.groupId,
      'canBeSeenBy': instance.canBeSeenBy,
      'durationInMins': instance.durationInMins,
      'feeForTheLesson': instance.feeForTheLesson,
      'feePerOccupant': instance.feePerOccupant,
      'lateCancellationPenalty': instance.lateCancellationPenalty,
      'levelFrom': instance.levelFrom,
      'levelUpto': instance.levelUpto,
      'autoAddWaitingStudents': instance.autoAddWaitingStudents,
      'scheduleTimeEnd': instance.scheduleTimeEnd,
    };
