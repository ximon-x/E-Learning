import 'package:client/pages/about_page.dart';
import 'package:client/pages/analytics_page.dart';
import 'package:client/pages/dashboard.dart';
import 'package:client/pages/quiz_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool signedIn = true;
  int _selectedIndex = 0;

  @override
  initState() {
    signedIn
        // ignore: avoid_print
        ? print("Signed in")
        : Navigator.pushReplacementNamed(context, "/login");

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('i-learn'),
          leading: const Icon(Icons.person),
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
}
