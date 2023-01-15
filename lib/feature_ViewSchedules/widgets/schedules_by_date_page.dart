import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teach_and_learn_teacher/feature_Auth/getx_controllers/user_controller.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/lesson_model.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_by_date_model.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/widgets/schedule_card.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/widgets/schedule_date_card.dart';

class SchedulesByDatePage extends HookWidget {
  final String date;
  final int currentPageIndex;

  const SchedulesByDatePage(
      {super.key, required this.date, required this.currentPageIndex});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();

    final ValueNotifier<List<ScheduleByDateModel>> schedules = useState([]);

    Future<void> getSchedules(teacherId, accessToken, date) async {
      print(date);
      try {
        final results = await Supabase.instance.client.functions.invoke(
            'proxy/get-teacher-schedules-by-date',
            headers: {'Authorization': 'Bearer $accessToken'},
            body: {"teacherId": teacherId, "date": date});

        final data = (results.data);

        if (results.data['isRequestSuccessful']) {
          List<ScheduleByDateModel> schedulesList = (data['data'] as List)
              .map((e) => ScheduleByDateModel.fromJson(e))
              .toList();

          schedules.value = schedulesList;
        } else {
          Get.snackbar('Oops..', results.data['error']);
        }
      } catch (error) {
        print(error);
      }
    }

    useEffect(() {
      if (userController.user.value.accessToken != '' &&
          schedules.value.isEmpty) {
        getSchedules(userController.user.value.id,
            userController.user.value.accessToken, date);
      }
    }, []);

    double getNumberOfBookedHours(List<LessonModel> lessons) {
      var sum = 0.0;

      for (var lesson in lessons) {
        sum = lesson.Lessons_LessonScheduleTimes!.length as double;
      }

      return sum;
    }

    int getNumberOfBookedPeople(List<LessonModel> lessons) {
      return lessons.length;
    }

    double getEstimatedMoney(List<LessonModel> lessons) {
      var sum = 0.0;

      for (var lesson in lessons) {
        sum = lesson.fee;
      }

      return sum;
    }

    int getNumberOfPeopleAttending(List<LessonModel> lessons) {
      var sum = 0;

      for (var lesson in lessons) {
        if (lesson.isAccepted!) {
          sum = sum + 1;
        }
      }

      return sum;
    }

    int getNumberOfPeopleInWaitingList(List<LessonModel> lessons) {
      var sum = 0;

      for (var lesson in lessons) {
        if (!lesson.isAccepted!) {
          sum = sum + 1;
        }
      }

      return sum;
    }

    return Column(children: [
      ScheduleDateCard(context, date),
      SingleChildScrollView(
        child: Column(
          children: schedules.value
              .map((schedule) => ScheduleCard(
                    schedule: schedule,
                    getEstimatedMoney: getEstimatedMoney,
                    getNumberOfBookedHours: getNumberOfBookedHours,
                    getNumberOfBookedPeople: getNumberOfBookedPeople,
                    getNumberOfPeopleAttending: getNumberOfPeopleAttending,
                    getNumberOfPeopleInWaitingList:
                        getNumberOfPeopleInWaitingList,
                  ))
              .toList(),
        ),
      )
    ]);
  }
}
