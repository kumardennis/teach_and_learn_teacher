import 'package:json_annotation/json_annotation.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/lesson_schedule_times_model.dart';

import 'lesson_student_model.dart';

part 'lessons_lesson_schedule_time_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Lesson_LessonScheduleTimeModel {
  Lesson_LessonScheduleTimeModel(this.LessonScheduleTimes);

  factory Lesson_LessonScheduleTimeModel.fromJson(Map<String, dynamic> json) =>
      _$Lesson_LessonScheduleTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$Lesson_LessonScheduleTimeModelToJson(this);

  LessonScheduleTimesModel LessonScheduleTimes;
}
