import 'package:iLearn/pages/about_page.dart';
import 'package:iLearn/pages/analytics_page.dart';
import 'package:iLearn/pages/dashboard.dart';
import 'package:iLearn/pages/quiz_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool signedIn = true;
  int _selectedIndex = 0;
  UserCredential? firebase;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget home() {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('i-learn'),
          leading: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                EasyLoading.show(
                    status: "loading...", maskType: EasyLoadingMaskType.black);

                Future.delayed(const Duration(seconds: 3));
                Navigator.pushReplacementNamed(context, "/profile");
                EasyLoading.dismiss();
              }),
          centerTitle: true,
          titleTextStyle: const TextStyle(fontWeight: FontWeight.bold)),
      body: _selectedIndex == 0
          ? const Dashboard()
          : _selectedIndex == 1
              ? const QuizPage()
              : _selectedIndex == 2
                  ? const AnalyticsPage()
                  : const AboutPage(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).primaryColorDark),
          selectedItemColor: Theme.of(context).primaryColorDark,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard),
              label: "Dashboard",
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.quiz),
              label: "Take Quiz",
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.upcoming),
              label: "Review",
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.info),
              label: "About",
              backgroundColor: Theme.of(context).primaryColor,
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (firebase != null && firebase?.user != null) {
    //   return home();
    // }

    return home();
  }
}
