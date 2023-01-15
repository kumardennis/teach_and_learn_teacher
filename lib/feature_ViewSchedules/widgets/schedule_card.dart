import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_by_date_model.dart';

class ScheduleCard extends HookWidget {
  final ScheduleByDateModel schedule;
  final Function getNumberOfBookedHours;
  final Function getNumberOfBookedPeople;
  final Function getEstimatedMoney;
  final Function getNumberOfPeopleAttending;
  final Function getNumberOfPeopleInWaitingList;

  const ScheduleCard({
    super.key,
    required this.schedule,
    required this.getNumberOfBookedHours,
    required this.getNumberOfBookedPeople,
    required this.getEstimatedMoney,
    required this.getNumberOfPeopleAttending,
    required this.getNumberOfPeopleInWaitingList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          DateFormat('HH:mm').format(DateTime.parse(
                              '${schedule.scheduleDate} ${schedule.scheduleTimeStart}')),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.gunmetal,
                                  fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                          DateFormat('HH:mm').format(DateTime.parse(
                              '${schedule.scheduleDate} ${schedule.scheduleTimeEnd}')),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .gunmetal,
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .gunmetal,
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .gunmetal,
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
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  schedule.maxOccupancy == 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5, top: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      color: Theme.of(context).colorScheme.blue,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                      'lbl_HoursBooked'.trParams({
                                        'hours': getNumberOfBookedHours(
                                                schedule.Lessons)
                                            .toString()
                                      }),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .gunmetal,
                                              fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5, top: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: FaIcon(
                                      FontAwesomeIcons.users,
                                      color: Theme.of(context).colorScheme.blue,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      'lbl_PeopleBooked'.trParams({
                                        'people': getNumberOfBookedPeople(
                                                schedule.Lessons)
                                            .toString()
                                      }),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .gunmetal,
                                              fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5, top: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: FaIcon(
                                      FontAwesomeIcons.euroSign,
                                      color: Theme.of(context).colorScheme.blue,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 23,
                                  ),
                                  Text(
                                      'lbl_EurosEstimated'.trParams({
                                        'euros':
                                            getEstimatedMoney(schedule.Lessons)
                                                .toString()
                                      }),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .gunmetal,
                                              fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5, top: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: FaIcon(
                                      FontAwesomeIcons.personRunning,
                                      color: Theme.of(context).colorScheme.blue,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                      'lbl_PeopleAttending'.trParams({
                                        'people': getNumberOfPeopleAttending(
                                                schedule.Lessons)
                                            .toString()
                                      }),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .gunmetal,
                                              fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5, top: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: FaIcon(
                                      FontAwesomeIcons.userLock,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .brightRed,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      'lbl_PeopleAllowed'.trParams({
                                        'people':
                                            schedule.maxOccupancy.toString()
                                      }),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .gunmetal,
                                              fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5, top: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: FaIcon(
                                      FontAwesomeIcons.userClock,
                                      color:
                                          Theme.of(context).colorScheme.yellow,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      'lbl_PeopleInWaiting'.trParams({
                                        'people':
                                            getNumberOfPeopleInWaitingList(
                                                    schedule.Lessons)
                                                .toString()
                                      }),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .gunmetal,
                                              fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          ],
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
