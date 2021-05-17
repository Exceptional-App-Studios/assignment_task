import 'package:assignment_app/services/api_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Task5 extends StatefulWidget {
  static const routeName = 'task-five';
  @override
  _Task5State createState() => _Task5State();
}

class _Task5State extends State<Task5> {
  get ss => setState(() {});

  List<dynamic> data = [];
  final tempData = [
    {"x_axis": 11, "y_axis": 29},
    {"x_axis": 18, "y_axis": 12},
    {"x_axis": 14, "y_axis": 18},
    {"x_axis": 17, "y_axis": 15},
  ];

  @override
  void initState() {
    super.initState();
    data = tempData;
  }

  bool dataLoaded = false;
  bool isLoading = false;
  String error = '';
  final api = ApiService();
  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.blueGrey.withOpacity(0.8)),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 5,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) => '$value'.split('.').first,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 10,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) => '$value'.split('.').first,
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 2,
          ),
          left: BorderSide(
            color: Color(0xff4e4965),
            width: 2,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      minY: 0,
      maxX: 50,
      maxY: 50,
      rangeAnnotations: RangeAnnotations(horizontalRangeAnnotations: [
        HorizontalRangeAnnotation(y1: 10, y2: 10)
      ]),
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      spots: [
        for (int i = 0; i < data.length; i++)
          FlSpot(data[i]['x_axis'].toDouble(), data[i]['y_axis'].toDouble()),
      ],
      isCurved: false,
      colors: [const Color(0xff4af699)],
      barWidth: 3,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
    );

    return [lineChartBarData1];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //Task 5: Showing Graph
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: width,
              height: 200,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: LineChart(
                  sampleData1(),
                  swapAnimationDuration: const Duration(milliseconds: 250),
                ),
              ),
            ),
            SizedBox(height: 150),
            Container(
              width: 219,
              height: 60,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        elevation: 10,
                        primary: HexColor('#363636'),
                      ),
                      onPressed: () async {
                        isLoading = true;
                        ss;
                        try {
                          data = await api.getGraph();
                          dataLoaded = true;
                          ss;
                        } catch (e) {
                          error = e.toString();
                          ss;
                          print(e);
                        }
                        isLoading = false;
                        ss;
                      },
                      child: Text(
                        'Load data from api',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
            ),
            SizedBox(height: 20),
            Container(
              width: 219,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  elevation: 10,
                  primary: Colors.green,
                ),
                onPressed: () async {
                  data = tempData;
                  ss;
                },
                child: Text(
                  'Load local data',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
