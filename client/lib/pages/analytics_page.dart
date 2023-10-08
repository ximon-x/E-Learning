import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            elevation: 10,
            shadowColor: Theme.of(context).primaryColor,
            child: Lottie.asset("assets/videos/your_mind.json"),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              const Text(
                  "Take a deep dive and learn about your strengths and weaknesses"),
              ElevatedButton(
                  onPressed: () {}, child: const Text("Analyze your Stats"))
            ]),
          ),
        ],
      ),
    );
  }
}
