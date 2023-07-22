import 'package:orderskatya/web_api/dto/payment.dart';

import 'order.dart';
import 'shipment.dart';

class Orders {
  String? sId;
  int? orderNumber;
  String? name;
  String? lastName;
  String? street;
  String? postCode;
  String? city;
  String? phone;
  String? email;
  String? comments;
  List<Order> order = [];
  Shipment? shipment;
  bool? archive;
  bool? newOrder;
  String? date;
  int? iV;
  bool? status;
  Payment? payment;

  Orders(
      {this.sId,
      this.orderNumber,
      this.name,
      this.lastName,
      this.street,
      this.postCode,
      this.city,
      this.phone,
      this.email,
      this.comments,
      required this.order,
      this.shipment,
      this.archive,
      this.newOrder,
      this.date,
      this.iV,
      this.status,
      this.payment});

  Orders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderNumber = json['orderNumber'];
    name = json['name'];
    lastName = json['lastName'];
    street = json['street'];
    postCode = json['postCode'];
    city = json['city'];
    phone = json['phone'];
    email = json['email'];
    comments = json['comments'];
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order.add(Order.fromJson(v));
      });
    }
    shipment =
        json['shipment'] != null ? Shipment.fromJson(json['shipment']) : null;
    archive = json['archive'];
    newOrder = json['newOrder'];
    date = json['date'];
    iV = json['__v'];
    status = json['status'];
    payment = json['payment'] != null ? Payment.fromJson(json['payment']) : null;
  }
}


