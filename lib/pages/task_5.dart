import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:assignment_app/models/chart_data.dart';
import 'package:assignment_app/Api/api_call.dart';
import 'package:hexcolor/hexcolor.dart';

class Task5 extends StatefulWidget {
  static const routeName = 'task-five';
  @override
  _Task5State createState() => _Task5State();
}

class _Task5State extends State<Task5> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    //Task 5: Showing Graph
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            child: FutureBuilder<List<Chartdata>>(
              future: ApiCall.ReadChartData(),
              builder: (context, snapshot) {
                final users = snapshot.data;
                print(users);
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return Center(child: Text('Something Happend Wrong!'));
                    } else {
                      return check
                          ? SfCartesianChart(
                              series: <ChartSeries>[
                                LineSeries<Chartdata, double>(
                                    dataSource: users,
                                    xValueMapper: (Chartdata c, _) =>
                                        double.parse(c.x.toString()),
                                    yValueMapper: (Chartdata c, _) =>
                                        double.parse(c.y.toString()),
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                    ))
                              ],
                            )
                          : Center(
                              child: Text("Press Any Button to Load Data"));
                    }
                }
              },
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 219,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  elevation: 10,
                  primary: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    check = true;
                  });
                },
                child: Text(
                  'Data From Api',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 219,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  elevation: 10,
                  primary: HexColor('#363636'),
                ),
                onPressed: () {},
                child: Text(
                  'Show local data',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
          Text("Local Is not Working", style: TextStyle(color: Colors.red)),
          Padding(padding: EdgeInsets.only(bottom: 20))
        ],
      ),
    );
  }
}
