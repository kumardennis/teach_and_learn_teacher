import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/feature_Auth/getx_controllers/user_controller.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/feature_Auth/utils/money_formatter.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/widgets/earnings_brief_card.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/widgets/previous_schedule_brief.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/widgets/upcoming_schedule_brief.dart';

class HomeScreen extends HookWidget {
  HomeScreen({Key? key}) : super(key: key);

  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.lineColor,
      body: Column(
        children: [
          EarningsBriefCard(context),
          PreviousSchedulesBrief(),
          UpcomingSchedulesBrief()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: Theme.of(context).colorScheme.blue,
        elevation: 8,
        child: FaIcon(
          FontAwesomeIcons.calendarPlus,
          color: Theme.of(context).colorScheme.snow,
          size: 30,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.blue,
          automaticallyImplyLeading: false,
          actions: const [],
          flexibleSpace: FlexibleSpaceBar(
            title: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Obx(() => Text(
                      'hd_Welcome'.trParams(
                          {'firstName': userController.user.value.firstName}),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    )),
              ),
            ),
            centerTitle: false,
            expandedTitleScale: 1.0,
          ),
          elevation: 10,
        ),
      ),
    );
  }
}
