import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

//I have converted the json data(got from API) to a list of Point objects which I used to represent a point on the graph.
//I have done using the package charts_flutter


class Task5 extends StatefulWidget {
  static const routeName = 'task-five';
  @override
  _Task5State createState() => _Task5State();
}

class _Task5State extends State<Task5> {
  bool checkData = false;
  bool load = false;
  bool success = false;
  var data;
  var response;
  getData() {
    if (data.length == 0) {
      return [];
    }
    return [
      new charts.Series<Point, int>(
        id: 'Points',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Point p, _) => p.x,
        measureFn: (Point p, _) => p.y,
        data: data,
      )
    ];
  }

  fetchData() async {
    checkData = true;
    setState(() {
      load = true;
    });
    try {
      response = await http.get(
          Uri.https('exceptional-studios.herokuapp.com', 'api/graph-task'));
      if (response.statusCode == 200) {
        print('Success');

        Iterable l = json.decode(response.body);
        List<Point> points =
        List<Point>.from(l.map((model) => Point.fromJson(model)));
        points.sort((a, b) {
          return a.x.compareTo(b.x);
        });
        data = points;
        setState(() {
          success=true;
          load = false;
        });
      } else {
        print(response.statusCode);
        print('Failed');
        setState(() {
          success=false;
          load = false;
        });
      }
    } catch (e) {
      print("Some error occured: " + e.toString());
      setState(() {
        success=false;
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              AspectRatio(
                aspectRatio: 1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: checkData
                      ? load
                      ? Center(child: CircularProgressIndicator())
                      : success
                      ? charts.LineChart(getData(),
                      defaultRenderer:
                      new charts.LineRendererConfig(
                          includePoints: true))
                      : Container(
                    color: Colors.cyanAccent,
                    child: Center(child: Text('Failed!',style: TextStyle(fontSize: 20),)),
                  )
                      : Container(
                    color: Colors.cyanAccent,
                  ),
                ),
              ),
              Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: 219,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    elevation: 5,
                    primary: HexColor('#009154'),
                  ),
                  onPressed: fetchData,
                  child: Text(
                    'Data from API',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: 219,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    elevation: 5,
                    primary: HexColor('#363636'),
                  ),
                  onPressed: () {
                    data = [
                      new Point(0, 0),
                      new Point(1, 1),
                      new Point(2, 1),
                      new Point(3, 3),
                    ];
                    success=true;
                    checkData = true;
                    setState(() {});
                  },
                  child: Text(
                    'Show local Data',
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

class Point {
  Point(this.x, this.y);
  final int x;
  final int y;

  static fromJson(json) {
    Point p = new Point(json['x_axis'], json['y_axis']);
    return p;
  }
}