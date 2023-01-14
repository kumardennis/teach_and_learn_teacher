import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/feature_Auth/getx_controllers/user_controller.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/getxControllers/upcoming_schedules_controller.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_model.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_response_model.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/widgets/date_brief_circle.dart';

class UpcomingSchedulesBrief extends HookWidget {
  final UserController userController = Get.put(UserController());
  final UpcomingSchedulesController upcomingSchedulesController =
      Get.put(UpcomingSchedulesController());

  ValueNotifier<List<ScheduleReponseModel>> schedules = useState([]);

  UpcomingSchedulesBrief({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      initializeDateFormatting('en_US', null);
    }, []);

    Future<void> getSchedules(teacherId, accessToken) async {
      try {
        final results = await Supabase.instance.client.functions.invoke(
            'proxy/get-teacher-schedules-grouped-date',
            headers: {'Authorization': 'Bearer $accessToken'},
            body: {"teacherId": teacherId, "isInPast": false});

        final data = (results.data);

        if (results.data['isRequestSuccessful']) {
          List<ScheduleReponseModel> schedulesList = (data['data'] as List)
              .map((e) => ScheduleReponseModel.fromJson(e))
              .toList();

          schedules.value = schedulesList;

          upcomingSchedulesController.loadUpcomingSchedules(schedulesList);
        } else {
          Get.snackbar('Oops..', results.data['error']);
        }
      } catch (error) {
        print(error);
      }
    }

    useEffect(() {
      initializeDateFormatting('en_US', null);
    }, []);

    useEffect(() {
      if (userController.user.value.accessToken != '') {
        getSchedules(userController.user.value.id,
            userController.user.value.accessToken);
      }
      return null;
    }, [userController.user.value.accessToken, userController.user.value.id]);

    return Container(
      child: Flexible(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Theme.of(context).colorScheme.snow,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.snow,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10, 20, 10, 20),
                        child: Text(
                          'hd_LessonsUpcoming'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.gunmetal,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Wrap(
                            // padding: const EdgeInsets.only(top: 8.0),
                            // crossAxisCount: 5,
                            runSpacing: 20,
                            children: schedules.value
                                .asMap()
                                .entries
                                .map((schedule) => GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/upcoming-schedules',
                                            arguments: {
                                              'dateIndex': schedule.key
                                            });
                                      },
                                      child: DateBriefCircle(
                                          context,
                                          schedule.value.date,
                                          schedule.value.scheduleData.length,
                                          false,
                                          schedules),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
