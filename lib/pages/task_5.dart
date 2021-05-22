import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Task5 extends StatefulWidget {
  static const routeName = 'task-five';
  @override
  _Task5State createState() => _Task5State();
}

class _Task5State extends State<Task5> {
  List listOfGraphData = [];
  List<String> graphXList = [];
  List<double> data = [];
  List<Feature> features = [];
  List<Feature> featuresLocal = [];
  bool buttonPressed = true;

  Future fetchData() async {
    http.Response response = await http
        .get(Uri.https('exceptional-studios.herokuapp.com', 'api/graph-task'));
    if (response.statusCode == 200) {
      setState(() {
        listOfGraphData = jsonDecode(response.body);
        data = [0.0];
        graphXList = ["0"];
        for (var i = 0; i < listOfGraphData.length; i++) {
          graphXList.add((listOfGraphData[i]['x_axis']).toString());
        }
        for (var i = 0; i < listOfGraphData.length; i++) {
          data.add(listOfGraphData[i]['y_axis'] / 100);
        }
        features = [
          Feature(
            data: data,
            color: Colors.blue,
          )
        ];
        buttonPressed = true;
      });
    }
  }

  Future fetchLocalData() async {
    var jsonPoints = await rootBundle.loadString('assets/points.json');
    setState(() {
      listOfGraphData = jsonDecode(jsonPoints);
      graphXList = [];
      data = [];
      for (var i = 0; i < listOfGraphData.length; i++) {
        graphXList.add((listOfGraphData[i]['x_axis']).toString());
      }
      for (var i = 0; i < listOfGraphData.length; i++) {
        data.add(listOfGraphData[i]['y_axis'] / 100);
      }
      featuresLocal = [Feature(data: data, color: Colors.yellow)];
    });
  }

  @override
  Widget build(BuildContext context) {
    //Task 5: Showing Graph
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LineGraph(
                features: buttonPressed ? features : featuresLocal,
                size: Size(MediaQuery.of(context).size.width / 1.5,
                    MediaQuery.of(context).size.width / 1.5),
                labelX: graphXList,
                labelY: ['1'],
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
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    setState(() {
                      data = [];
                      graphXList = [];
                      buttonPressed = true;
                      fetchData();
                    });
                  },
                  child: Text(
                    'Data from api',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 219,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    elevation: 10,
                    primary: Color(0xFF363636),
                  ),
                  onPressed: () {
                    setState(() {
                      buttonPressed = false;
                      fetchLocalData();
                    });
                  },
                  child: Text(
                    'Data from api',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
