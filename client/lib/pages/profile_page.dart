import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          title: Text("Signed in as dummy@gmail.com"),
          leading: Icon(Icons.person_sharp, size: 50),
        ),
        const ListTile(
          title: Text("Below are your stats"),
          leading: Icon(Icons.bar_chart, size: 50),
        ),
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
