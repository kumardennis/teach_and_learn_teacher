import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/feature_AddEditSchedule/screens/add_group_schedule.dart';
import 'package:teach_and_learn_teacher/feature_AddEditSchedule/screens/add_individual_schedule.dart';
import 'package:teach_and_learn_teacher/feature_AddEditSchedule/widgets/add_schedule-type_chips.dart';
import 'package:teach_and_learn_teacher/shared_widgets/DrawerMenu.dart';

class AddSchedule extends HookWidget {
  AddSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.lineColor,
        drawer: const DrawerMenu(),
        body:
            TabBarView(children: [AddIndividualSchedule(), AddGroupSchedule()]),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.blue,
          actions: const [],
          title: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Text(
                'hd_AddSchedule'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          elevation: 10,
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.snow,
                fontWeight: FontWeight.bold),
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(
                    color: Theme.of(context).colorScheme.gunmetal,
                    fontWeight: FontWeight.bold),
            indicatorColor: Theme.of(context).colorScheme.snow,
            indicator: BoxDecoration(
                color: Theme.of(context).colorScheme.blue,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                boxShadow: const [BoxShadow(color: Colors.black12)]),
            tabs: [
              Tab(
                text: 'lbl_Individuals'.tr,
                icon: const FaIcon(
                  FontAwesomeIcons.person,
                ),
              ),
              Tab(
                text: 'lbl_OneTimeGroup'.tr,
                icon: const FaIcon(
                  FontAwesomeIcons.peopleGroup,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
