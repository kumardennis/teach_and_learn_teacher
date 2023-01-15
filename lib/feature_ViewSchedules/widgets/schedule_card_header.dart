import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_by_date_model.dart';

class ScheduleCardHeader extends HookWidget {
  final ScheduleByDateModel schedule;

  const ScheduleCardHeader({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                DateFormat('HH:mm').format(DateTime.parse(
                    '${schedule.scheduleDate} ${schedule.scheduleTimeStart}')),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.gunmetal,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 2,
            ),
            Text(
                DateFormat('HH:mm').format(DateTime.parse(
                    '${schedule.scheduleDate} ${schedule.scheduleTimeEnd}')),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.gray,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        schedule.maxOccupancy == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('lbl_Individuals'.tr,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.gunmetal,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 2,
                  ),
                  FaIcon(
                    FontAwesomeIcons.person,
                    color: Theme.of(context).colorScheme.blue,
                    size: 22,
                  )
                ],
              )
            : schedule.isRegularGroup!
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('lbl_RegularGroup'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.gunmetal,
                                  fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 2,
                      ),
                      FaIcon(
                        FontAwesomeIcons.peopleGroup,
                        color: Theme.of(context).colorScheme.blue,
                        size: 22,
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('lbl_Group'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.gunmetal,
                                  fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 2,
                      ),
                      FaIcon(
                        FontAwesomeIcons.peopleGroup,
                        color: Theme.of(context).colorScheme.blue,
                        size: 22,
                      )
                    ],
                  ),
        Column(children: [
          FaIcon(
            FontAwesomeIcons.cloudscale,
            color: Theme.of(context).colorScheme.blue,
            size: 24,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
              '${'lbl_Level'.tr} ${schedule.levelFrom} - ${schedule.levelUpto}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.gunmetal,
                  fontWeight: FontWeight.bold))
        ])
      ],
    );
  }
}
