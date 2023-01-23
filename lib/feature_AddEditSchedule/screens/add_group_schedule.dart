import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/feature_AddEditSchedule/widgets/add_schedule-type_chips.dart';
import 'package:teach_and_learn_teacher/shared_widgets/DrawerMenu.dart';

class AddGroupSchedule extends HookWidget {
  AddGroupSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [Text('group')]));
  }
}
