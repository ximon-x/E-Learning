import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<_ChartData> _chartData;
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

    _tooltip = TooltipBehavior(enable: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text("Welcome to iLearn!"),
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
          )
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
