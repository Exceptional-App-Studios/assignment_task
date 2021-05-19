import 'package:assignment_app/models/graph_model.dart';
import 'package:assignment_app/models/sale_model.dart';
import 'package:assignment_app/services/graph_api.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Task5 extends StatefulWidget {
  static const routeName = 'task-five';
  @override
  _Task5State createState() => _Task5State();
}

class _Task5State extends State<Task5> {

  bool showChart = false;
  bool chartTypeLocal = false;

  List<SalesData> _chartData;
  List<GraphModel> _apiData;

  TooltipBehavior _tooltipBehavior;

  

  Future loadApiData() async {
    setState(() async {
      _apiData = await GraphApi().getDataofChart();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    //Task 5: Showing Graph
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              showChart==true 
              ? chartTypeLocal==false 
                ? getChart()
                : getLocalChart()
              : Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width*0.9,
              ),
              Column(
                children: [
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
                      onPressed: (){
                        getChart();
                      },
                      child: Text(
                        'Data From Api',
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
                        primary: HexColor('#363636'),
                      ),
                      onPressed: () {
                        getLocalChart();
                      },
                      child: Text(
                        'Show Local Data',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30)
    ];
    return chartData;
  }

  Container getChart() {

    setState(() {
      loadApiData();
      showChart = true;
      chartTypeLocal = false;  
    });
    
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width*0.9,
      child: SfCartesianChart(
        selectionType:SelectionType.series,
        title: ChartTitle(text: 'Api Data Graph'),
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          LineSeries<GraphModel, double>(
              name: 'Sales',
              dataSource: _apiData,
              xValueMapper: (GraphModel xaxis, _) => xaxis.xAxis.toDouble(),
              yValueMapper: (GraphModel yaxis, _) => yaxis.yAxis,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true)
        ],
      ),
    );
  }

  Widget getLocalChart(){

    initState(){

    }
    setState(() {
      showChart = true;
      chartTypeLocal = true;  
    });
    
    _chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30)
    ];
    _tooltipBehavior = TooltipBehavior(enable: true);
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width*0.9,
      child: SfCartesianChart(
        title: ChartTitle(text: 'Yearly sales analysis'),
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          LineSeries<SalesData, double>(
              name: 'Sales',
              dataSource: _chartData,
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true)
        ],
        primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}M',
            numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
      ),
    );
  }
  
}
