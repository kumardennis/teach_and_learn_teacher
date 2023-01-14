import 'package:json_annotation/json_annotation.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/lesson_model.dart';

part 'lesson_schedule_times_model.g.dart';

@JsonSerializable()
class LessonScheduleTimesModel {
  String scheduleId;
  String time;
  bool? isBooked;
  String id;

  LessonScheduleTimesModel(this.scheduleId, this.time, this.isBooked, this.id,
      [LessonModel? lessonModel]);

  factory LessonScheduleTimesModel.fromJson(Map<String, dynamic> json) =>
      _$LessonScheduleTimesModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonScheduleTimesModelToJson(this);
}
