import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/color_scheme.dart';
import 'package:teach_and_learn_teacher/feature_Auth/getx_controllers/user_controller.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    final UserController userController = Get.find();

    return Drawer(
      key: scaffoldKey,
      elevation: 8,
      backgroundColor: Theme.of(context).colorScheme.lineColor,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.snow,
                boxShadow: const [BoxShadow(color: Colors.black12)]),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.network(
                      'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  '${userController.user.value.firstName} ${userController.user.value.lastName}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.blue),
                )
              ],
            ),
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.snow,
            onTap: () {
              Get.toNamed('/home-screen');
            },
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                FaIcon(
                  FontAwesomeIcons.house,
                  color: Theme.of(context).colorScheme.gunmetal,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('lbl_Home'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.gunmetal,
                          fontWeight: FontWeight.bold)),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
