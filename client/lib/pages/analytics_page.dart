import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  void handleAnalytics() {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );

    Future.delayed(const Duration(seconds: 3))
        .then((value) => null)
        .whenComplete(() => EasyLoading.showSuccess("Success!"));
  }

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
                  onPressed: handleAnalytics,
                  child: const Text("Analyze your Stats"))
            ]),
          ),
        ],
      ),
    );
  }
}
