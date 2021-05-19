import 'dart:ffi';

class ChartData {
  String Company;
  String Sale;

  ChartData({
    this.Company,
    this.Sale,
  });

  static ChartData fromJson(json) =>
      ChartData(Company: json['Company'], Sale: json['Sale']);
}
