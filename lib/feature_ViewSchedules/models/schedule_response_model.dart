import 'package:json_annotation/json_annotation.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_model.dart';

part 'schedule_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduleReponseModel {
  final List<ScheduleModel> scheduleData;
  final String date;

  ScheduleReponseModel(this.scheduleData, this.date);

  factory ScheduleReponseModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleReponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleReponseModelToJson(this);
}
