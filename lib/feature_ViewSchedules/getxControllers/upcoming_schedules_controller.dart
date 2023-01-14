import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_model.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_response_model.dart';

class UpcomingSchedulesController extends GetxController {
  RxList<ScheduleReponseModel> upcomingSchedules = [
    ScheduleReponseModel([
      ScheduleModel(
        '',
        '',
        '',
        '',
        null,
        '',
        0,
        '',
        null,
        '',
        '',
        0,
        null,
        null,
        null,
        0,
        0,
        false,
        '',
      )
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

  loadUpcomingSchedules(List<ScheduleReponseModel> updatedSchedules) =>
      upcomingSchedules.value = updatedSchedules;
}
