import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/getxControllers/upcoming_schedules_controller.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/widgets/schedule_date_card.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/widgets/schedules_by_date_page.dart';
import 'package:teach_and_learn_teacher/shared_widgets/DrawerMenu.dart';

class UpcomingSchedules extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var startingIndex = Get.arguments['dateIndex'];

    PageController pageController =
        usePageController(initialPage: startingIndex);

    final UpcomingSchedulesController upcomingSchedulesController =
        Get.put(UpcomingSchedulesController());

    final ValueNotifier currentPageIndex = useState(startingIndex);

    Future<void> handlePageChange(int page) async {
      debugPrint(page.toString());
      currentPageIndex.value = page;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.lineColor,
      body: PageView(
        onPageChanged: handlePageChange,
        controller: pageController,
        children: upcomingSchedulesController.upcomingSchedules
            .map((element) => SchedulesByDatePage(
                  date: element.date,
                  currentPageIndex: currentPageIndex.value,
                ))
            .toList(),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.blue,
          actions: const [],
          flexibleSpace: FlexibleSpaceBar(
            title: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Text(
                  'hd_LessonsUpcoming'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          elevation: 10,
        ),
      ),
      drawer: DrawerMenu(),
    );
  }
}
