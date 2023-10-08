import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool signedIn = true;

  @override
  initState() {
    signedIn
        // ignore: avoid_print
        ? print("Signed in")
        : Navigator.pushReplacementNamed(context, "/login");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('i-learn'),
          leading: const Icon(Icons.person),
          centerTitle: true,
          titleTextStyle: const TextStyle(fontWeight: FontWeight.bold)),
      body: const Center(),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.dashboard),
          label: "Dashboard",
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.quiz),
          label: "Take Quiz",
          backgroundColor: Theme.of(context).primaryColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.work_history),
          label: "Review Progress",
          backgroundColor: Theme.of(context).primaryColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.info),
          label: "About the Project",
          backgroundColor: Theme.of(context).primaryColor,
        )
      ]),
    );
  }
}
