import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/feature_AddEditSchedule/locales/en_locale.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/locales/en_locale.dart';

import '../feature_Auth/locales/en_locale.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'lbl_Home': 'Home',
          'lbl_Individuals': 'Individuals',
          'lbl_Group': 'Group',
          'lbl_RegularGroup': 'Regular group',
          'lbl_Level': 'Level',
          'lbl_Ok': 'Ok',
          'lbl_Cancel': 'Cancel',
          ...authLocales_EN,
          ...viewScheduleLocales_EN,
          ...addEditScheduleLocales_EN
        },
        'et_EE': {
          'hello': 'Hallo Welt',
        }
      };
}
