import 'package:client/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:client/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'i-Learn',
        theme: XAppTheme.lightTheme,
        darkTheme: XAppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: SplashScreen());
  }
}
