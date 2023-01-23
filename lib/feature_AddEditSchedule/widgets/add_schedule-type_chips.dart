import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';

class AddScheduleTypeChips extends HookWidget {
  const AddScheduleTypeChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Chip(
              elevation: 8,
              backgroundColor: Theme.of(context).colorScheme.blue,
              label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.person,
                      color: Theme.of(context).colorScheme.snow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'lbl_Individuals'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.snow,
                                fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )),
          Chip(
              elevation: 2,
              backgroundColor: Theme.of(context).colorScheme.gunmetal,
              label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.peopleGroup,
                      color: Theme.of(context).colorScheme.snow,
                      size: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'lbl_OneTimeGroup'.tr,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.snow,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
