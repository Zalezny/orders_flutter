import 'method.dart';
import 'point.dart';

class Shipment {
  Method? method;
  Point? point;

  Shipment({this.method, this.point});

  Shipment.fromJson(Map<String, dynamic> json) {
    method = json['method'] != null ? Method.fromJson(json['method']) : null;
    point = json['point'] != null ? Point.fromJson(json['point']) : null;
  }
}
