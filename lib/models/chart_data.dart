import 'dart:ffi';

class Chartdata {
  int x;
  int y;

  Chartdata({
    this.x,
    this.y,
  });

  static Chartdata fromJson(json) =>
      Chartdata(x: json['x_axis'], y: json['y_axis']);
}
