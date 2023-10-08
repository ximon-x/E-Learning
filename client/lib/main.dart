import 'package:client/pages/analytics_page.dart';
import 'package:client/pages/home_page.dart';
import 'package:client/pages/login_page.dart';
import 'package:client/pages/profile_page.dart';
import 'package:client/pages/quiz_page.dart';
import 'package:client/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "/home": (context) => const HomePage(),
          "/login": (context) => const LoginPage(),
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
