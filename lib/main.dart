import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/screens/home_screen.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/screens/previous_schedules.dart';
import 'package:teach_and_learn_teacher/feature_ViewSchedules/screens/upcoming_schedules.dart';
import 'package:teach_and_learn_teacher/locales/locale_en.dart';

import 'feature_Auth/screens/sign_in.dart';

void main() async {
  await dotenv.load(fileName: "../.env");
  await Supabase.initialize(
      url: 'http://localhost:54321',
      anonKey: dotenv.env['SUPABASE_LOCAL_ANON_KEY'] ?? '');
  runApp(MyApp(
    home: SignIn(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({@required this.home});
  final home;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme:
              GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
      home: home,
      initialRoute: '/sign-in',
      getPages: [
        GetPage(name: '/sign-in', page: () => SignIn()),
        GetPage(name: '/home-screen', page: () => HomeScreen()),
        GetPage(name: '/upcoming-schedules', page: () => UpcomingSchedules()),
        GetPage(name: '/previous-schedules', page: () => PreviousSchedules())
      ],
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text(widget.title),
//   //     ),
//   //     body: SignIn(),
//   //     floatingActionButton: FloatingActionButton(
//   //       onPressed: _incrementCounter,
//   //       tooltip: 'Increment',
//   //       child: const Icon(Icons.add),
//   //     ),
//   //   );
//   // }
// }

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
