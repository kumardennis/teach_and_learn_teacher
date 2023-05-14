import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/constants.dart';
import 'package:teach_and_learn_teacher/feature_Auth/getx_controllers/user_controller.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/getxControllers/upcoming_schedules_controller.dart';
import 'package:teach_and_learn_teacher/shared_models/address_response_model.dart';
import 'package:teach_and_learn_teacher/shared_models/subcategory_response_model.dart';
import 'package:time_range_picker/time_range_picker.dart';

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = this.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

class AddGroupSchedule extends HookWidget {
  AddGroupSchedule({Key? key}) : super(key: key);

  final UserController userController = Get.find();
  final UpcomingSchedulesController upcomingSchedulesController = Get.find();

  @override
  Widget build(BuildContext context) {
    final feeController = useTextEditingController();
    final maxOccupancyController = useTextEditingController();

    final currentLevelRange = useState(const RangeValues(1, 5));
    final selectedDates = useState([]);
    final selectedTimeRange = useState(TimeRange(
        startTime: const TimeOfDay(hour: 09, minute: 0),
        endTime: const TimeOfDay(hour: 11, minute: 0)));

    final canBeSeenBy = useState('');
    final selectedAddress = useState('');

    final ValueNotifier<List<AddressResponseModel>> addresses = useState([]);
    final ValueNotifier<List<SubcategoryResponseModel>> subcategories =
        useState([]);

    final ValueNotifier<String> subcategory = useState('');

    final ValueNotifier<List<DateTime>> specialExistingDate = useState([]);

    useEffect(() {
      final List<DateTime> existingDates = [];

      for (var schedule in upcomingSchedulesController.upcomingSchedules) {
        existingDates.add(DateTime.parse(schedule.date));
      }

      specialExistingDate.value = existingDates;
    }, [upcomingSchedulesController.upcomingSchedules]);

    Future<void> createTeacherSchedule() async {
      final teacherId = userController.user.value.id;
      final accessToken = userController.user.value.accessToken;

      final alreadyMadeSchedules =
          upcomingSchedulesController.upcomingSchedules;

      final existingDates = [];

      for (var date in selectedDates.value) {
        final existingDate = alreadyMadeSchedules.firstWhereOrNull((schedule) =>
            schedule.date == DateFormat('yyyy-MM-dd').format(date));

        if (existingDate != null) {
          for (var data in existingDate.scheduleData) {
            bool isHinderanceToExistingTimes = false;

            final existingDateStartTime = DateTime.parse(
                '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${data.scheduleTimeStart.toString()}');
            final existingDateEndTime = DateTime.parse(
                '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${data.scheduleTimeEnd.toString()}');

            final selectedDateStartTime = DateTime.parse(
                '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${selectedTimeRange.value.startTime.to24hours().toString()}');
            final selectedDateEndTime = DateTime.parse(
                '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${selectedTimeRange.value.endTime.to24hours().toString()}');

            /* existingTimeStart is in between selectedTimes */
            if (existingDateStartTime.compareTo(selectedDateEndTime) < 0 &&
                existingDateStartTime.compareTo(selectedDateStartTime) > 0) {
              isHinderanceToExistingTimes = true;
            }

            /* existingTimeEnd is in between selectedTimes */
            if (existingDateEndTime.compareTo(selectedDateEndTime) <= 0 &&
                existingDateEndTime.compareTo(selectedDateStartTime) >= 0) {
              isHinderanceToExistingTimes = true;
            }

            /* selectedTimeStart is in between existingTimes */
            if (selectedDateStartTime.compareTo(existingDateEndTime) <= 0 &&
                selectedDateStartTime.compareTo(existingDateStartTime) >= 0) {
              isHinderanceToExistingTimes = true;
            }

            /* selectedTimeEnd is in between existingTimes */
            if (selectedDateEndTime.compareTo(existingDateStartTime) <= 0 &&
                selectedDateEndTime.compareTo(existingDateEndTime) >= 0) {
              isHinderanceToExistingTimes = true;
            }

            if (isHinderanceToExistingTimes) {
              Get.snackbar('Oops...', 'Times overlapping with existing ones');
              return;
            }
          }

          existingDates.add(date);
        }
      }

      // CoolAlert.show(
      //     context: context,
      //     type: CoolAlertType.success,
      //     title: 'hd_SchedulesCreated'.tr,s
      //     text: 'inf_SchedulesCreated'.tr,
      //     flareAnimationName: 'play',
      //     flareAsset: 'animation.flr',
      //     onConfirmBtnTap: () {
      //       Get.toNamed('/home-screen');
      //     });

      try {
        final response = await Supabase.instance.client.functions
            .invoke('proxy/create-teacher-schedule', headers: {
          'Authorization': 'Bearer $accessToken'
        }, body: {
          "teacherId": teacherId,
          "scheduleTimeStart": selectedTimeRange.value.startTime.to24hours(),
          "scheduleTimeEnd": selectedTimeRange.value.endTime.to24hours(),
          "scheduleDates": selectedDates.value
              .map((e) => DateFormat('yyyy-MM-dd').format(e))
              .toList(),
          "maxOccupancy": maxOccupancyController.text,
          "subcategoryId": subcategory.value,
          "canBeSeenBy": canBeSeenBy.value,
          "feeForTheLesson": feeController.text,
          "lateCancellationPenalty": 10,
          "levelFrom": currentLevelRange.value.start,
          "levelUpto": currentLevelRange.value.end,
          "addressIds": [selectedAddress.value]
        });

        final data = response.data;

        if (data['isRequestSuccessful']) {
          // AwesomeDialog(
          //   dialogBackgroundColor: Theme.of(context).colorScheme.snow,
          //   btnOkColor: Theme.of(context).colorScheme.blue,
          //   barrierColor: Theme.of(context).colorScheme.green,
          //   btnCancel: null,
          //   context: context,
          //   dialogType: DialogType.success,
          //   animType: AnimType.rightSlide,
          //   title: 'hd_SchedulesCreated'.tr,
          //   desc: 'inf_SchedulesCreated'.tr,
          //   btnOkOnPress: () {
          //     Get.toNamed('/home-screen');
          //   },
          // ).show();

          Get.toNamed('/home-screen');
        } else {
          Get.snackbar('Oops..', data['error']);
        }
      } catch (err) {
        debugPrint(err.toString());
      }
    }

    Future<void> getTeacherAddresses(teacherId, accessToken) async {
      try {
        final response = await Supabase.instance.client.functions.invoke(
            'proxy/get-teacher-addresses',
            headers: {'Authorization': 'Bearer $accessToken'},
            body: {"teacherId": teacherId, "isInPast": false});

        final data = response.data;

        if (data['isRequestSuccessful']) {
          List<AddressResponseModel> addressList = (data['data'] as List)
              .map((e) => AddressResponseModel.fromJson(e))
              .toList();

          addresses.value = addressList;
        } else {
          Get.snackbar('Oops..', data['error']);
        }
      } catch (err) {
        debugPrint(err.toString());
      }
    }

    Future<void> getTeacherSubcategories(teacherId, accessToken) async {
      try {
        final response = await Supabase.instance.client.functions.invoke(
            'proxy/get-teacher-subcategories',
            headers: {'Authorization': 'Bearer $accessToken'},
            body: {"teacherId": teacherId, "isInPast": false});

        final data = response.data;

        print(data['data']);

        if (data['isRequestSuccessful']) {
          List<SubcategoryResponseModel> subcategoryList =
              (data['data'] as List)
                  .map((e) => SubcategoryResponseModel.fromJson(e))
                  .toList();

          subcategories.value = subcategoryList;
        } else {
          Get.snackbar('Oops..', data['error']);
        }
      } catch (err) {
        debugPrint(err.toString());
      }
    }

    useEffect(() {
      if (userController.user.value.accessToken != '') {
        getTeacherAddresses(userController.user.value.id,
            userController.user.value.accessToken);

        getTeacherSubcategories(userController.user.value.id,
            userController.user.value.accessToken);
      }
      return null;
    }, [userController.user.value.accessToken, userController.user.value.id]);

    final List<CanBeSeenByOption> canBeSeenByOptions = [
      CanBeSeenByOption(
          id: constants['canBeSeenBy']['onlySchoolMembers'],
          label: 'lbl_OnlySchoolMembers'.tr),
      CanBeSeenByOption(
          id: constants['canBeSeenBy']['onlySubcategoryPeople'],
          label: 'lbl_OnlySubcategoryPeople'.tr),
      CanBeSeenByOption(
          id: constants['canBeSeenBy']['everyone'], label: 'lbl_Everyone'.tr),
    ];

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.snow,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 0.5, blurRadius: 3)
              ]),
          child: SfDateRangePicker(
            monthViewSettings: DateRangePickerMonthViewSettings(
              specialDates: specialExistingDate.value.isNotEmpty
                  ? specialExistingDate.value
                  : [DateTime(2020, 01, 01)],
            ),
            monthCellStyle: DateRangePickerMonthCellStyle(
              specialDatesTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.snow),
              specialDatesDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.yellow,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.yellow, width: 1),
                  shape: BoxShape.circle),
            ),
            todayHighlightColor: Theme.of(context).colorScheme.blue,
            enablePastDates: false,
            view: DateRangePickerView.month,
            selectionColor: Theme.of(context).colorScheme.blue,
            selectionMode: DateRangePickerSelectionMode.multiple,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              selectedDates.value = args.value;
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context)
                          .colorScheme
                          .snow, //background color of button
                      elevation: 8, //elevation of button
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'lbl_SelectTime'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context).colorScheme.blue,
                                    fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: FaIcon(
                              FontAwesomeIcons.clock,
                              color: Theme.of(context).colorScheme.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                    onPressed: () async {
                      TimeRange result = await showTimeRangePicker(
                        interval: const Duration(minutes: 30),
                        backgroundColor:
                            Theme.of(context).colorScheme.lineColor,
                        handlerColor: Theme.of(context).colorScheme.blue,
                        strokeColor: Theme.of(context).colorScheme.blue,
                        selectedColor: Theme.of(context).colorScheme.blue,
                        ticksColor: Theme.of(context).colorScheme.snow,
                        ticksLength: 12,
                        ticksWidth: 10,
                        clockRotation: 180,
                        context: context,
                        padding: 50,
                        strokeWidth: 10,
                        snap: true,
                        labelOffset: -30,
                        start: const TimeOfDay(hour: 9, minute: 0),
                        end: const TimeOfDay(hour: 11, minute: 0),
                        disabledColor: Theme.of(context).colorScheme.brightRed,
                        disabledTime: TimeRange(
                            startTime: const TimeOfDay(hour: 21, minute: 0),
                            endTime: const TimeOfDay(hour: 7, minute: 0)),
                        labels: [
                          "00:00",
                          "03:00",
                          "06:00",
                          "09:00",
                          "12:00",
                          "15:00",
                          "18:00",
                          "21:00"
                        ].asMap().entries.map((e) {
                          return ClockLabel.fromIndex(
                              idx: e.key, length: 8, text: e.value);
                        }).toList(),
                      );

                      selectedTimeRange.value = result;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chip(
                        label: Text(
                          selectedTimeRange.value.startTime.to24hours(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.lineColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.blue,
                        elevation: 8,
                      ),
                      const SizedBox(
                        width: 15,
                        child: Center(child: Text('-')),
                      ),
                      Chip(
                        label: Text(
                          selectedTimeRange.value.endTime.to24hours(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.lineColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.blue,
                        elevation: 8,
                      )
                    ],
                  ),
                )
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(
              top: 15.0, bottom: 15.0, left: 8.0, right: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.snow,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 0.5, blurRadius: 3)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Text(
                  'lbl_SelectAddress'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.blue),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    spacing: 0.5,
                    runSpacing: 0.5,
                    children: addresses.value
                        .map((e) => ChoiceChip(
                              elevation: 8,
                              selectedColor: Theme.of(context).colorScheme.blue,
                              label: Text(
                                e.Addresses.name,
                                style: TextStyle(
                                    color:
                                        selectedAddress.value == e.Addresses.id
                                            ? Theme.of(context).colorScheme.snow
                                            : Theme.of(context)
                                                .colorScheme
                                                .gunmetal),
                              ),
                              selected: selectedAddress.value == e.Addresses.id,
                              onSelected: (bool selected) {
                                selectedAddress.value = e.Addresses.id;
                              },
                            ))
                        .toList(),
                  ),
                ),
              ]),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.snow,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 0.5, blurRadius: 3)
              ]),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 0.5,
                runSpacing: 0.5,
                children: canBeSeenByOptions
                    .map((e) => ChoiceChip(
                          elevation: 8,
                          selectedColor: Theme.of(context).colorScheme.blue,
                          label: Text(
                            e.label,
                            style: TextStyle(
                                color: canBeSeenBy.value == e.id
                                    ? Theme.of(context).colorScheme.snow
                                    : Theme.of(context).colorScheme.gunmetal),
                          ),
                          selected: canBeSeenBy.value == e.id,
                          onSelected: (bool selected) {
                            canBeSeenBy.value = e.id;
                          },
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 0.5,
                runSpacing: 0.5,
                children: subcategories.value
                    .map((e) => ChoiceChip(
                          elevation: 8,
                          selectedColor: Theme.of(context).colorScheme.blue,
                          label: Text(
                            e.Subcategories.name,
                            style: TextStyle(
                                color: subcategory.value == e.Subcategories.id
                                    ? Theme.of(context).colorScheme.snow
                                    : Theme.of(context).colorScheme.gunmetal),
                          ),
                          selected: subcategory.value == e.Subcategories.id,
                          onSelected: (bool selected) {
                            subcategory.value = e.Subcategories.id;
                          },
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'lbl_TotalFee'.tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.gunmetal,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      width: 100,
                      child: TextField(
                        controller: feeController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.end,
                        cursorColor: Theme.of(context).colorScheme.blue,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 10.0, bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'lbl_MaxOccupancy'.tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.gunmetal,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      width: 100,
                      child: TextField(
                        controller: maxOccupancyController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.end,
                        cursorColor: Theme.of(context).colorScheme.blue,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'lbl_Level'.tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.gunmetal,
                      fontWeight: FontWeight.bold),
                ),
                RangeSlider(
                  activeColor: Theme.of(context).colorScheme.blue,
                  values: currentLevelRange.value,
                  max: 5,
                  divisions: 4,
                  min: 1,
                  labels: RangeLabels(
                    currentLevelRange.value.start.toString(),
                    currentLevelRange.value.end.toString(),
                  ),
                  onChanged: (RangeValues values) {
                    currentLevelRange.value = values;
                  },
                )
              ],
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: ConfirmationSlider(
            foregroundColor: Theme.of(context).colorScheme.blue,
            onConfirmation: () => createTeacherSchedule(),
          ),
        )
      ]),
    ));
  }
}

class CanBeSeenByOption {
  final String id;
  final String label;

  CanBeSeenByOption({required this.id, required this.label});
}
