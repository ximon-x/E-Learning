import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<_PieData> _pieData;

  @override
  initState() {
    _pieData = [
      _PieData('Math', 25, 'Math'),
      _PieData('English', 38, 'English'),
      _PieData('History', 34, 'History'),
      _PieData('General', 52, 'General')
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        child: const Text(
          "Welcome to iLearn!",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      Card(
        elevation: 10,
        shadowColor: Theme.of(context).primaryColor,
        child: Lottie.asset("assets/videos/man_lecturing_woman.json"),
      ),
      const Padding(padding: EdgeInsets.all(10)),
      Card(
          elevation: 10,
          shadowColor: Theme.of(context).primaryColor,
          child: SfCircularChart(
              title: ChartTitle(text: 'Your Performance'),
              legend: const Legend(isVisible: true),
              series: <PieSeries<_PieData, String>>[
                PieSeries<_PieData, String>(
                    explode: true,
                    explodeIndex: 0,
                    dataSource: _pieData,
                    xValueMapper: (_PieData data, _) => data.xData,
                    yValueMapper: (_PieData data, _) => data.yData,
                    dataLabelMapper: (_PieData data, _) => data.text,
                    dataLabelSettings:
                        const DataLabelSettings(isVisible: true)),
              ])),
    ]));
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}
