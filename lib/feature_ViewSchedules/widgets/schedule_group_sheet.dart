import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/feature_Auth/getx_controllers/user_controller.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/models/schedule_by_date_model.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/widgets/schedule_card_header.dart';

class ScheduleGroupSheet extends HookWidget {
  final ScheduleByDateModel scheduleDetails;
  final Function getNumberOfBookedHours;
  final Function getNumberOfBookedPeople;
  final Function getEstimatedMoney;
  final Function getNumberOfPeopleAttending;
  final Function getNumberOfPeopleInWaitingList;
  final Function acceptStudent;

  const ScheduleGroupSheet(
      {super.key,
      required this.scheduleDetails,
      required this.getNumberOfBookedHours,
      required this.getNumberOfBookedPeople,
      required this.getEstimatedMoney,
      required this.getNumberOfPeopleAttending,
      required this.getNumberOfPeopleInWaitingList,
      required this.acceptStudent});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ScheduleCardHeader(schedule: scheduleDetails),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.personRunning,
                            color: Theme.of(context).colorScheme.blue,
                            size: 24,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                              'hd_Attendees'.trParams({
                                'people': getNumberOfPeopleAttending(
                                        scheduleDetails.Lessons)
                                    .toString()
                              }),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .gunmetal,
                                      fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.personCircleMinus,
                            color: Theme.of(context).colorScheme.yellow,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              'lbl_SpotsVacant'.trParams({
                                'spots': (scheduleDetails.maxOccupancy -
                                        getNumberOfPeopleAttending(
                                            scheduleDetails.Lessons))
                                    .toString()
                              }),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .gunmetal,
                                      fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: scheduleDetails.Lessons.where((lesson) =>
                            lesson.isAccepted != null && lesson.isAccepted!)
                        .map((lesson) => Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 2,
                                          blurRadius: 5)
                                    ],
                                    color: Theme.of(context).colorScheme.blue,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 30.0,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: ClipOval(
                                                  child: Image.network(
                                                    'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg',
                                                    height: 30,
                                                    width: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '${lesson.Students!.firstName} ${lesson.Students!.lastName}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .snow,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .gunmetal,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    8.0))),
                                                    child: Center(
                                                      child: FaIcon(
                                                        FontAwesomeIcons.phone,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .snow,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .gunmetal,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    8.0))),
                                                    child: Center(
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidEnvelope,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .snow,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.userClock,
                        color: Theme.of(context).colorScheme.yellow,
                        size: 22,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                          'hd_WaitingList'.trParams({
                            'people': getNumberOfPeopleInWaitingList(
                                    scheduleDetails.Lessons)
                                .toString()
                          }),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.gunmetal,
                                  fontWeight: FontWeight.bold))
                    ],
                  ),
                  Column(
                    children: scheduleDetails.Lessons.where((lesson) =>
                            lesson.isAccepted == null ||
                            (lesson.isAccepted != null
                                ? !lesson.isAccepted!
                                : false))
                        .map((lesson) => Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 2,
                                          blurRadius: 5)
                                    ],
                                    color: Theme.of(context).colorScheme.yellow,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 30.0,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: ClipOval(
                                                  child: Image.network(
                                                    'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg',
                                                    height: 30,
                                                    width: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '${lesson.Students!.firstName} ${lesson.Students!.lastName}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .gunmetal,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .gunmetal,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    8.0))),
                                                    child: Center(
                                                      child: FaIcon(
                                                        FontAwesomeIcons.phone,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .snow,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .gunmetal,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    8.0))),
                                                    child: Center(
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidEnvelope,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .snow,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            acceptStudent(
                                                scheduleDetails.id,
                                                lesson.id,
                                                scheduleDetails.teacherId,
                                                true);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .blue,
                                                borderRadius: const BorderRadius
                                                        .only(
                                                    topLeft:
                                                        Radius.circular(8.0),
                                                    bottomRight:
                                                        Radius.circular(8.0))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.userPlus,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .snow,
                                                    size: 15,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'lbl_AddToSchedule'.tr,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .snow,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
