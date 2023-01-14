import 'package:get/get.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  var user = UserModel(
          '', '', '', '', null, null, null, null, null, null, '', '', '', '')
      .obs;

  loadUser(UserModel updatedUser) => user.value = updatedUser;
}
