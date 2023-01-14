import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_response_model.dart';

Widget DateBriefCircle(BuildContext context, String dateString, int badgeCount,
    bool isInPast, ValueNotifier<List<ScheduleReponseModel>> schedules) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
    child: Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.snow,
        shape: BoxShape.circle,
      ),
      child: Badge(
        badgeContent: Text(
          badgeCount.toString(),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.snow,
              ),
        ),
        showBadge: true,
        shape: BadgeShape.circle,
        badgeColor: isInPast!
            ? Theme.of(context).colorScheme.brightRed
            : Theme.of(context).colorScheme.green,
        elevation: 4,
        padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        position: BadgePosition.topEnd(),
        animationType: BadgeAnimationType.scale,
        toAnimate: true,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.blue,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat(
                  'yyyy',
                ).format(DateTime.parse(dateString)),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Theme.of(context).colorScheme.snow, fontSize: 8.0),
              ),
              Text(
                DateFormat(
                  'MMM dd',
                ).format(DateTime.parse(dateString)),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).colorScheme.snow,
                    ),
              ),
              Text(
                DateFormat(
                  'EEE',
                ).format(DateTime.parse(dateString)),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Theme.of(context).colorScheme.snow, fontSize: 12.0),
              ),
              // Icon(
              //   Icons.arrow_forward_rounded,
              //   color: Theme.of(context).colorScheme.snow,
              //   size: 20,
              // ),
            ],
          ),
        ),
      ),
    ),
  );
}
