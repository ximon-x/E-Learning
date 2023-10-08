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
        title: Text("Developed by Tosin"),
        leading: Icon(Icons.person_sharp, size: 50),
      ),
      ListTile(
        title: Text("tosin@officialmail.com"),
        leading: Icon(Icons.mail_sharp, size: 50),
      ),
      ListTile(
        title: Text("Built using Flutter and Flask"),
        leading: Icon(Icons.devices_sharp, size: 50),
      ),
    ]))));
  }
}
