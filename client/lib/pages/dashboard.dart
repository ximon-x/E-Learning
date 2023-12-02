import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final int day;

  final int score;
  ChartData(this.day, this.score);
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List scores = [];

  List<ChartData> mathDataSource = [];
  List<ChartData> englishDataSource = [];
  List<ChartData> historyDataSource = [];
  List<ChartData> generalDataSource = [];

  late TooltipBehavior _tooltip;

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
                legend: const Legend(isVisible: true),
                tooltipBehavior: _tooltip,
                primaryXAxis: NumericAxis(
                  minimum: DateTime.now().day - 6,
                  maximum: DateTime.now().day + 1,
                  interval: 1,
                ),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: 10,
                  interval: 2,
                ),
                title: ChartTitle(
                    text: "Performance (Last 7 Days)",
                    textStyle: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold)),
                series: <ChartSeries>[
                  ScatterSeries(
                      name: "Math",
                      color: Colors.blue,
                      dataSource: mathDataSource,
                      xValueMapper: (data, _) => data.day,
                      yValueMapper: (data, _) => data.score),
                  ScatterSeries(
                      name: "English",
                      color: Colors.red,
                      dataSource: englishDataSource,
                      xValueMapper: (data, _) => data.day,
                      yValueMapper: (data, _) => data.score),
                  ScatterSeries(
                      name: "History",
                      color: Colors.green,
                      dataSource: historyDataSource,
                      xValueMapper: (data, _) => data.day,
                      yValueMapper: (data, _) => data.score),
                  ScatterSeries(
                      name: "General",
                      color: Colors.yellow,
                      dataSource: generalDataSource,
                      xValueMapper: (data, _) => data.day,
                      yValueMapper: (data, _) => data.score),
                ])),
      ),
      const Padding(padding: EdgeInsets.all(10)),
    ])));
  }

  fetchScores() async {
    List fetchedScores = [];
    final collection = FirebaseFirestore.instance.collection("scores");
    await collection.get().then((value) {
      for (var element in value.docs) {
        final data = element.data();

        // if data is not older than 7 days
        if (data["timestamp"].toDate().difference(DateTime.now()).inDays > 7) {
          continue;
        }

        // if data is not from current user
        if (data["user"] != FirebaseAuth.instance.currentUser!.uid) {
          continue;
        }

        var score = {
          "subject": data["subject"],
          "chartData": ChartData(data["timestamp"].toDate().day, data["score"])
        };

        fetchedScores.add(score);
      }
    });

    return fetchedScores;
  }

  @override
  initState() {
    fetchScores().then((value) {
      setState(() {
        scores = value;

        for (var score in scores) {
          if (score["subject"] == "Math") {
            mathDataSource.add(score["chartData"]);
          } else if (score["subject"] == "English") {
            englishDataSource.add(score["chartData"]);
          } else if (score["subject"] == "History") {
            historyDataSource.add(score["chartData"]);
          } else if (score["subject"] == "General") {
            generalDataSource.add(score["chartData"]);
          }
        }
      });
    });

    _tooltip = TooltipBehavior(enable: true);

    super.initState();
  }
}
