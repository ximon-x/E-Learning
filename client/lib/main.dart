import 'package:client/firebase_options.dart';
import 'package:client/pages/analytics_page.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/pages/profile_page.dart';
import 'package:client/pages/quiz_page.dart';
import 'package:client/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  //   // ignore: avoid_print
  // ).then((value) => print(value));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "/home": (context) => const HomePage(),
          "/analytics": (context) => const AnalyticsPage(),
          "/profile": (context) => const ProfilePage(),
          "/quiz": (context) => const QuizPage()
        },
        title: 'i-Learn',
        builder: EasyLoading.init(),
        theme: XAppTheme.lightTheme,
        darkTheme: XAppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomePage());
  }
}
