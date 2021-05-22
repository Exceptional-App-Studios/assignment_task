import 'package:assignment_app/models/chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Task5 extends StatefulWidget {
  static const routeName = 'task-five';
  @override
  _Task5State createState() => _Task5State();
}

class _Task5State extends State<Task5> {

   bool onpressed = false;
  final data = [
    new ChartData(10, 4),
    new ChartData(12, 5),
    new ChartData(15, 37),
    new ChartData(17, 12),
    new ChartData(20, 25),
    new ChartData(22, 40),
  ];

  
  @override
  Widget build(BuildContext context) {
    //Task 5: Showing Graph
   return Scaffold(
        body: Center(
          child: Container(
            height: 550,
            padding: EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    onpressed ? Text("Graph of Local Data") : Text(""),
                    SizedBox(height: 10),
                    onpressed
                        ? localData()
                        : Container(
                            child: Expanded(
                                child: Center(
                                    child: Text(
                                        "Show a linear graph of your choice here"))),
                          ),
                    Spacer(),
                    Container(
                      height: 50,
                      width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          elevation: 10,
                          primary: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            onpressed = true;
                          });
                        },
                        child: Text(
                          'Load local data',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          elevation: 10,
                          primary: Colors.red,
                        ),
                        child: Text(
                          'Load remote  data',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));

  }
  
_getLinearChart() {
    List<charts.Series<ChartData, int>> series = [
      charts.Series(
          id: "Sales",
          data: data,
          domainFn: (ChartData series, _) => series.year,
          measureFn: (ChartData series, _) => series.sales,
          colorFn: (ChartData series, _) =>
              charts.MaterialPalette.blue.shadeDefault)
    ];
    return series;
  }
   Widget localData() {
    return Container(
      child: Expanded(
        child: new charts.LineChart(
        _getLinearChart(),
          animate: true,
        ),
      ),
    );
  }
}
