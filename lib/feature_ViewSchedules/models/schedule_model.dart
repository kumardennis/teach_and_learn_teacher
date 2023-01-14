import 'package:json_annotation/json_annotation.dart';

part 'schedule_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduleModel {
  final String id;
  final String created_at;
  final String scheduleTimeStart;
  final String scheduleDate;
  final bool? isBooked;
  final String teacherId;
  final int maxOccupancy;
  final String subcategoryId;
  final bool? isRegularGroup;
  final String? groupId;
  final String canBeSeenBy;
  final int? durationInMins;
  final double? feeForTheLesson;
  final double? feePerOccupant;
  final double? lateCancellationPenalty;
  final int levelFrom;
  final int levelUpto;
  final bool? autoAddWaitingStudents;
  final String scheduleTimeEnd;

  ScheduleModel(
    this.id,
    this.created_at,
    this.scheduleTimeStart,
    this.scheduleDate,
    this.isBooked,
    this.teacherId,
    this.maxOccupancy,
    this.subcategoryId,
    this.isRegularGroup,
    this.groupId,
    this.canBeSeenBy,
    this.durationInMins,
    this.feeForTheLesson,
    this.feePerOccupant,
    this.lateCancellationPenalty,
    this.levelFrom,
    this.levelUpto,
    this.autoAddWaitingStudents,
    this.scheduleTimeEnd,
  );

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}
