import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/locales/en_locale.dart';

import '../feature_Auth/locales/en_locale.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          ...authLocales_EN,
          ...viewScheduleLocales_EN
        },
        'et_EE': {
          'hello': 'Hallo Welt',
        }
      };
}
