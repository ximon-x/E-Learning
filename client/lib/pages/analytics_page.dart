import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  void handleAnalytics() {
    EasyLoading.show(
      status: 'Analyzing...',
      maskType: EasyLoadingMaskType.black,
    );

    Future.delayed(const Duration(seconds: 3))
        .then((value) => null)
        .whenComplete(() =>
            EasyLoading.showSuccess("Successful Analysis \n Go to Profile"));
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

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late List<_ChartData> _chartData;
  late List<_StackedColumnData> _stackedColumnData;
  late TooltipBehavior _tooltip;

  @override
  initState() {
    _chartData = [
      _ChartData('Jun', 23),
      _ChartData('Jul', 59),
      _ChartData('Aug', 34),
      _ChartData('Sep', 49),
      _ChartData('Oct', 67)
    ];

    _stackedColumnData = [
      _StackedColumnData("Oct 4", 67, 64, 52, 32),
      _StackedColumnData("Oct 5", 72, 74, 54, 40),
      _StackedColumnData("Oct 6", 57, 34, 59, 32),
      _StackedColumnData("Oct 7", 72, 44, 60, 75),
      _StackedColumnData("Oct 8", 72, 54, 32, 91),
    ];

    _tooltip = TooltipBehavior(enable: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
            }),
      ),
      body: Column(children: [
        const ListTile(
          title: Text("Below are your stats"),
          leading: Icon(Icons.person_sharp, size: 50),
        ),
        Card(
            elevation: 10,
            shadowColor: Theme.of(context).primaryColor,
            child: SfCartesianChart(
                legend: const Legend(isVisible: true),
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                    NumericAxis(minimum: 50, maximum: 400, interval: 50),
                tooltipBehavior: _tooltip,
                series: <ChartSeries>[
                  StackedColumnSeries<_StackedColumnData, String>(
                      dataSource: _stackedColumnData,
                      xValueMapper: (_StackedColumnData score, _) => score.day,
                      yValueMapper: (_StackedColumnData score, _) => score.math,
                      name: 'Math',
                      markerSettings: const MarkerSettings(isVisible: true)),
                  StackedColumnSeries<_StackedColumnData, String>(
                      dataSource: _stackedColumnData,
                      xValueMapper: (_StackedColumnData score, _) => score.day,
                      yValueMapper: (_StackedColumnData score, _) =>
                          score.english,
                      name: 'English',
                      markerSettings: const MarkerSettings(isVisible: true)),
                  StackedColumnSeries<_StackedColumnData, String>(
                      dataSource: _stackedColumnData,
                      xValueMapper: (_StackedColumnData score, _) => score.day,
                      yValueMapper: (_StackedColumnData score, _) =>
                          score.general,
                      name: 'General',
                      markerSettings: const MarkerSettings(isVisible: true)),
                  StackedColumnSeries<_StackedColumnData, String>(
                      dataSource: _stackedColumnData,
                      xValueMapper: (_StackedColumnData score, _) => score.day,
                      yValueMapper: (_StackedColumnData score, _) =>
                          score.history,
                      name: 'History',
                      markerSettings: const MarkerSettings(isVisible: true)),
                ])),
        Card(
          elevation: 10,
          shadowColor: Theme.of(context).primaryColor,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 20, maximum: 80, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              LineSeries<_ChartData, String>(
                  dataSource: _chartData,
                  xValueMapper: (_ChartData sales, _) => sales.x,
                  yValueMapper: (_ChartData sales, _) => sales.y,
                  name: 'Sales',
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ],
          ),
        ),
      ]),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class _StackedColumnData {
  _StackedColumnData(
      this.day, this.math, this.english, this.history, this.general);

  final String day;

  final double math;
  final double english;
  final double history;
  final double general;
}

// late List<_PieData> _pieData;


//     _pieData = [
//       _PieData('Math', 25, 'Math'),
//       _PieData('English', 38, 'English'),
//       _PieData('History', 34, 'History'),
//       _PieData('General', 52, 'General')
//     ];

      // Card(
      //     elevation: 10,
      //     shadowColor: Theme.of(context).primaryColor,
      //     child: SfCircularChart(
      //         title: ChartTitle(text: 'Your Performance'),
      //         legend: const Legend(isVisible: true),
      //         series: <PieSeries<_PieData, String>>[
      //           PieSeries<_PieData, String>(
      //               explode: true,
      //               explodeIndex: 0,
      //               dataSource: _pieData,
      //               xValueMapper: (_PieData data, _) => data.xData,
      //               yValueMapper: (_PieData data, _) => data.yData,
      //               dataLabelMapper: (_PieData data, _) => data.text,
      //               dataLabelSettings:
      //                   const DataLabelSettings(isVisible: true)),
      //         ])),


// class _PieData {
//   _PieData(this.xData, this.yData, this.text);
//   final String xData;
//   final num yData;
//   final String text;
// }