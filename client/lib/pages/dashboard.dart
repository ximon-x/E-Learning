import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List scores = [];

  Future fetchScores() async {
    final fetchedScores = [];
    final collection = FirebaseFirestore.instance.collection("scores");
    collection.get().then((value) {
      for (var element in value.docs) {
        final data = element.data();

        if (data["user"] == FirebaseAuth.instance.currentUser!.uid) {
          var score = {
            "score": element["score"],
            "date": element["timestamp"].toDate(),
            "subject": element["subject"]
          };
          fetchedScores.add(score);
        }
      }
    });

    //
    return fetchedScores;
  }

  @override
  initState() {
    // final List<ChartData> chartData = [
    //   ChartData(2010, 32),
    //   ChartData(2011, 40),
    //   ChartData(2012, 34),
    //   ChartData(2013, 52),
    //   ChartData(2014, 42),
    //   ChartData(2015, 38),
    //   ChartData(2016, 41),
    // ];

    fetchScores().then((value) => setState(() {
          scores = value;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        child: const Text(
          "Welcome to iLearn!",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 10,
          shadowColor: Theme.of(context).primaryColor,
          child: Lottie.asset("assets/videos/man_lecturing_woman.json"),
        ),
      ),
      const Padding(padding: EdgeInsets.all(10)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
            elevation: 10,
            shadowColor: Theme.of(context).primaryColor,
            child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                title: ChartTitle(text: "User Activity"),
                series: const <ChartSeries>[
                  // // Renders scatter chart
                  // ScatterSeries<ChartData, DateTime>(
                  //     dataSource: chartData,
                  //     xValueMapper: (ChartData data, _) => data.x,
                  //     yValueMapper: (ChartData data, _) => data.y)
                ])),
      ),
      const Padding(padding: EdgeInsets.all(10)),
    ])));
  }
}

class ChartData {
  ChartData(int x, int y);
}
