import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iLearn/utils/helpers.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class ChartData {
  final int day;

  final int score;
  ChartData(this.day, this.score);
}

class ColumnData {
  final num total;

  final String subject;
  ColumnData(this.total, this.subject);
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late bool analyzed = false;

  String bestSubject = "";
  String worstSubject = "";
  num bestHour = 0;
  num averageScore = 0;

  List<ChartData> mathChartDataSource = [];
  List<ChartData> englishChartDataSource = [];
  List<ChartData> historyChartDataSource = [];
  List<ChartData> generalChartDataSource = [];

  List<ColumnData> columnDataSource = [];

  List scores = [];

  late TooltipBehavior _tooltip;

  analyticsRequest() {
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
              ElevatedButton(
                  onPressed: handleAnalytics,
                  child: const Text("Analyze your Stats"))
            ]),
          ),
        ],
      ),
    );
  }

  analyticsResponse() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Text(
        "Your Statistics",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      // Total Tests Taken
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
            elevation: 10,
            shadowColor: Theme.of(context).primaryColor,
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(minimum: 0, maximum: 50, interval: 5),
                tooltipBehavior: _tooltip,
                title: ChartTitle(
                    text: "Total Score",
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 10)),
                series: <ChartSeries>[
                  ColumnSeries(
                    dataSource: columnDataSource,
                    xValueMapper: (data, _) => data.subject,
                    yValueMapper: (data, _) => data.total,
                  )
                ])),
      ),
      const Padding(padding: EdgeInsets.all(10)),
      // Your Best Subject
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
            elevation: 10,
            shadowColor: Theme.of(context).primaryColor,
            child: Column(children: [
              ListTile(
                title: Text(
                  "Your best subject is $bestSubject",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10),
                ),
                leading: const Icon(Icons.gpp_good_sharp, size: 30),
              ),
              ListTile(
                title: Text(
                  worstSubject,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10),
                ),
                leading: const Icon(Icons.gpp_bad_sharp, size: 30),
              ),
              ListTile(
                title: Text(
                  "You performed the best at $bestHour:00",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10),
                ),
                leading: const Icon(Icons.alarm_on_sharp, size: 30),
              ),
            ])),
      ),

      const Padding(padding: EdgeInsets.all(10)),
      // Tests Taken
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
            elevation: 10,
            shadowColor: Theme.of(context).primaryColor,
            child: SfCartesianChart(
                title: ChartTitle(
                    text: "Activity (Past Month)",
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 10)),
                primaryXAxis: NumericAxis(
                  minimum:
                      DateTime.now().day - 30 < 0 ? 0 : DateTime.now().day - 30,
                  maximum: DateTime.now().day + 1,
                  interval: 3,
                ),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: 10,
                  interval: 2,
                ),
                tooltipBehavior: _tooltip,
                series: <ChartSeries>[
                  LineSeries<ChartData, int>(
                      color: Colors.blue,
                      dataSource: mathChartDataSource,
                      xValueMapper: (ChartData data, _) => data.day,
                      yValueMapper: (ChartData data, _) => data.score,
                      name: "Math"),
                  LineSeries<ChartData, int>(
                      color: Colors.red,
                      dataSource: englishChartDataSource,
                      xValueMapper: (ChartData data, _) => data.day,
                      yValueMapper: (ChartData data, _) => data.score,
                      name: "English"),
                  LineSeries<ChartData, int>(
                      color: Colors.green,
                      dataSource: historyChartDataSource,
                      xValueMapper: (ChartData data, _) => data.day,
                      yValueMapper: (ChartData data, _) => data.score,
                      name: "History"),
                  LineSeries<ChartData, int>(
                      color: Colors.yellow,
                      dataSource: generalChartDataSource,
                      xValueMapper: (ChartData data, _) => data.day,
                      yValueMapper: (ChartData data, _) => data.score,
                      name: "General"),
                ])),
      )
    ])));
  }

  @override
  Widget build(BuildContext context) {
    return analyzed ? analyticsResponse() : analyticsRequest();
  }

  fetchScores() async {
    List fetchedScores = [];
    final collection = FirebaseFirestore.instance.collection("scores");
    await collection.get().then((value) {
      for (var element in value.docs) {
        final data = element.data();

        // if data is not from current user
        if (data["user"] != FirebaseAuth.instance.currentUser!.uid) {
          continue;
        }

        var score = {
          "subject": data["subject"],
          "score": data["score"],
          "timestamp": data["timestamp"],
          "chartData": ChartData(data["timestamp"].toDate().day, data["score"]),
        };

        fetchedScores.add(score);
      }
    });

    return fetchedScores;
  }

  void handleAnalytics() {
    try {
      EasyLoading.show(
        status: 'Analyzing...',
        maskType: EasyLoadingMaskType.black,
      );

      fetchScores().then((value) {
        setState(() {
          scores = value;

          num mathTotal = 0;
          num englishTotal = 0;
          num historyTotal = 0;
          num generalTotal = 0;

          for (var score in scores) {
            if (score["subject"] == "Math") {
              mathTotal += score["score"];

              if (score["timestamp"]
                      .toDate()
                      .difference(DateTime.now())
                      .inDays <
                  30) {
                mathChartDataSource.add(score["chartData"]);
              }
            } else if (score["subject"] == "English") {
              englishTotal += score["score"];

              if (score["timestamp"]
                      .toDate()
                      .difference(DateTime.now())
                      .inDays <
                  30) {
                englishChartDataSource.add(score["chartData"]);
              }
            } else if (score["subject"] == "History") {
              historyTotal += score["score"];

              if (score["timestamp"]
                      .toDate()
                      .difference(DateTime.now())
                      .inDays <
                  30) {
                historyChartDataSource.add(score["chartData"]);
              }
            } else if (score["subject"] == "General") {
              generalTotal += score["score"];

              if (score["timestamp"]
                      .toDate()
                      .difference(DateTime.now())
                      .inDays <
                  30) {
                generalChartDataSource.add(score["chartData"]);
              }
            }
          }

          columnDataSource = [
            ColumnData(mathTotal, "Math"),
            ColumnData(englishTotal, "English"),
            ColumnData(historyTotal, "History"),
            ColumnData(generalTotal, "General"),
          ];

          bestHour = getBestHour(scores);
          bestSubject = getBestSubject(scores);
          worstSubject = getWorstSubject(scores);

          analyzed = true;
        });
      });

      EasyLoading.dismiss();
    } catch (error) {
      EasyLoading.showError("Something went wrong. Please try again later.");
      EasyLoading.showError("Error: $error");
    }
  }

  @override
  initState() {
    _tooltip = TooltipBehavior(enable: true);

    super.initState();
  }
}
