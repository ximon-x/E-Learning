import 'package:iLearn/firebase_options.dart';
import 'package:iLearn/pages/analytics_page.dart';
import 'package:iLearn/pages/home_page.dart';
import 'package:iLearn/pages/quiz_page.dart';
import 'package:iLearn/themes/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, GoogleAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Future.delayed(const Duration(seconds: 3));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  const googleClientId =
      "441078407889-r3uvegehsok186nsthu6gaqofmfpjhtl.apps.googleusercontent.com";

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(clientId: googleClientId),
  ]);

  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];
    return MaterialApp(
        initialRoute:
            FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/profile',
        routes: {
          "/home": (context) => const HomePage(),
          "/analytics": (context) => const AnalyticsPage(),
          // "/profile": (context) => const ProfilePage(),
          "/quiz": (context) => const QuizPage(),
          '/sign-in': (context) {
            return SignInScreen(
              providers: providers,
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  Navigator.pushReplacementNamed(context, '/home');
                }),
              ],
            );
          },
          '/profile': (context) {
            return ProfileScreen(
              providers: providers,
              actions: [
                SignedOutAction((context) {
                  Navigator.pushReplacementNamed(context, '/sign-in');
                }),
              ],
            );
          },
        },
        title: 'i-Learn',
        builder: EasyLoading.init(),
        theme: XAppTheme.lightTheme,
        darkTheme: XAppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomePage());
  }
}
