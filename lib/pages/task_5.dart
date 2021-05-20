import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class Task5 extends StatefulWidget {
  static const routeName = 'task-five';
  @override
  _Task5State createState() => _Task5State();
}

class _Task5State extends State<Task5> {
  final tempData = [
    {"x_axis": 35, "y_axis": 29},
    {"x_axis": 12, "y_axis": 12},
    {"x_axis": 14, "y_axis": 18},
    {"x_axis": 17, "y_axis": 45},
  ];
  List<dynamic> data;
  bool localData = false;
  bool apiData = false;
  bool start = false;

  Future<List<dynamic>> fetchGraph() async {
    final response =
    await http.get(Uri.https('exceptional-studios.herokuapp.com', 'api/graph-task'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    data = tempData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Task 5: Showing Graph
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width-40,
                  height: MediaQuery.of(context).size.width-40,
                  color: Colors.lightBlueAccent[100],
                  child: LineChart(
                    LineChartData(

                      minX: 0,
                      maxX: 50,
                      minY: 0,
                      maxY: 50,
                      lineBarsData: start?showData():null,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: 219,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 10,
                      primary: Colors.green[700],
                    ),
                    onPressed: ()  async{
                      localData = false;
                      apiData = true;
                      start = true;
                      data = await fetchGraph();
                      print(data);
                      setState(() {

                      });
                    },
                    child: Text(
                      'Data from api',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 219,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 10,
                      primary: Colors.black,
                    ),
                    onPressed: ()  async{
                      localData = true;
                      apiData = false;
                      start = true;
                      data = tempData;
                      setState(() {
                      });
                    },
                    child: Text(
                      'Show local data',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  List<LineChartBarData> showData() {
    final lineChartBarData1 = LineChartBarData(
      spots: [
        for (int i = 0; i < data.length; i++)
          FlSpot(data[i]['x_axis'].toDouble(), data[i]['y_axis'].toDouble()),
      ],
    );
    return [lineChartBarData1];
  }
}
