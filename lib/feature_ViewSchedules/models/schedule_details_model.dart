import 'package:json_annotation/json_annotation.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/lesson_model.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/lesson_schedule_times_model.dart';
import 'package:teach_and_learn_teacher/shared_models/subcategory_model.dart';

part 'schedule_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduleDetailsModel {
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
  final SubcategoryModel Subcategories;
  List<LessonScheduleTimesModel> LessonScheduleTimes;
  List<LessonModel> Lessons;

  ScheduleDetailsModel(
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
      this.Subcategories,
      this.LessonScheduleTimes,
      this.Lessons);

  factory ScheduleDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDetailsModelToJson(this);
}
