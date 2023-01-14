import 'package:json_annotation/json_annotation.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/address_model.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/lessons_lesson_schedule_time_model.dart';

import 'lesson_student_model.dart';

part 'lesson_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LessonModel {
  LessonModel(
      this.id,
      this.fee,
      this.studentComment,
      this.teacherComment,
      this.studentRating,
      this.teacherRating,
      this.studentSkillLevelRating,
      this.hasLessonEnded,
      this.hasLessonEndedEarly,
      this.hasLessonStarted,
      this.isInWaitingList,
      this.isAccepted,
      this.isChild,
      this.Addresses,
      this.Students,
      this.Lessons_LessonScheduleTimes);

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  String id;
  double fee;
  String? studentComment;
  String? teacherComment;
  int? studentRating;
  int? teacherRating;
  int? studentSkillLevelRating;
  bool? hasLessonEnded;
  bool? hasLessonEndedEarly;
  bool? hasLessonStarted;
  bool? isInWaitingList;
  bool? isAccepted;
  bool? isChild;
  AddressModel? Addresses;
  LessonStudentModel? Students;
  List<Lesson_LessonScheduleTimeModel>? Lessons_LessonScheduleTimes;
}
