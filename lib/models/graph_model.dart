import 'dart:convert';

GraphModel graphModelFromJson(String str) => GraphModel.fromJson(json.decode(str));

String graphModelToJson(GraphModel data) => json.encode(data.toJson());

class GraphModel {
    GraphModel({
        this.xAxis,
        this.yAxis,
    });

    int xAxis;
    int yAxis;

    factory GraphModel.fromJson(Map<String, dynamic> json) => GraphModel(
        xAxis: json["x_axis"],
        yAxis: json["y_axis"],
    );

    Map<String, dynamic> toJson() => {
        "x_axis": xAxis,
        "y_axis": yAxis,
    };
}
