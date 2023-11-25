import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Card(
                child: Column(children: [
      ListTile(
        title: Text(
          "Developed by Oluwatosin Olubudun",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
        leading: Icon(Icons.person_sharp, size: 30),
      ),
      ListTile(
        title: Text(
          "001273051",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
        leading: Icon(Icons.numbers, size: 30),
      ),
      ListTile(
        title: Text(
          "Built using Flutter and Flask",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
        leading: Icon(Icons.devices_sharp, size: 30),
      ),
    ]))));
  }
}
