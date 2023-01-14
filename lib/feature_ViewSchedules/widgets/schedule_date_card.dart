import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/feature_Auth/utils/money_formatter.dart';

import '../../feature_Auth/getx_controllers/user_controller.dart';

Widget ScheduleDateCard(BuildContext context, String dateString) {
  final UserController userController = Get.find();

  final String date =
      DateFormat('dd MMMM yyyy').format(DateTime.parse(dateString));
  final String day = DateFormat('EEEE').format(DateTime.parse(dateString));

  return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 45,
            width: 30,
            child: IconButton(
                color: Theme.of(context).colorScheme.gunmetal,
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
          ),
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Theme.of(context).colorScheme.gunmetal,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10, 10, 10, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .snow,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  day,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .snow,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
          ),
          SizedBox(
            height: 45,
            width: 30,
            child: IconButton(
                color: Theme.of(context).colorScheme.gunmetal,
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.arrowRight)),
          ),
        ],
      ));
}
