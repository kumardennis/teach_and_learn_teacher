import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/lesson_schedule_times_model.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_model.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_response_model.dart';

class PreviousSchedulesController extends GetxController {
  RxList<ScheduleReponseModel> upcomingSchedules = [
    ScheduleReponseModel([
      ScheduleModel('', '', '', '', null, '', 0, '', null, '', '', 0, null,
          null, null, 0, 0, false, '')
    ], '')
  ].obs;
  // RxList<ScheduleReponseModel> upcomingSchedules = [
  //   {
  //     'date': '',
  //     'scheduleDate': [
  //       ScheduleModel('', '', '', '', null, '', 0, '', null, '', '', 0, null,
  //           null, null, 0, 0, false, '')
  //     ]
  //   }
  // ].obs;

  loadPreviousSchedules(List<ScheduleReponseModel> updatedSchedules) =>
      upcomingSchedules.value = updatedSchedules;
}
