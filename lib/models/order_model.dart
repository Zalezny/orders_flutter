import 'dart:ffi';

class OrderList {
  final List<Orders>? orders;

  OrderList({required this.orders});
  factory OrderList.fromJson(List<dynamic> json) {
    List<Orders> orders = json.map((i) => Orders.fromJson(i)).toList();
    return OrderList(orders: orders);
  }
}

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
      this.iV});

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
        order!.add(new Order.fromJson(v));
      });
    }
    shipment = json['shipment'] != null
        ? new Shipment.fromJson(json['shipment'])
        : null;
    archive = json['archive'];
    newOrder = json['newOrder'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['orderNumber'] = this.orderNumber;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['street'] = this.street;
    data['postCode'] = this.postCode;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['comments'] = this.comments;
    if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    if (this.shipment != null) {
      data['shipment'] = this.shipment!.toJson();
    }
    data['archive'] = this.archive;
    data['newOrder'] = this.newOrder;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}

class Order {
  String? title;
  List<String>? color;
  int? quantity;
  int? price;
  String photo = "";
  String? size;

  Order(
      {this.title,
      this.color,
      this.quantity,
      this.price,
      required this.photo,
      this.size});

  Order.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    color = json['color'].cast<String>();
    quantity = json['quantity'];
    price = json['price'];
    photo = json['photo'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['color'] = this.color;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['size'] = this.size;
    return data;
  }
}

class Shipment {
  Method? method;
  Point? point;

  Shipment({this.method, this.point});

  Shipment.fromJson(Map<String, dynamic> json) {
    method =
        json['method'] != null ? new Method.fromJson(json['method']) : null;
    point = json['point'] != null ? new Point.fromJson(json['point']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.method != null) {
      data['method'] = this.method!.toJson();
    }
    if (this.point != null) {
      data['point'] = this.point!.toJson();
    }
    return data;
  }
}

class Method {
  String? sId;
  String? kind;
  int? price;
  int? iV;

  Method({this.sId, this.kind, this.price, this.iV});

  Method.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    kind = json['kind'];
    price = json['price'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['kind'] = this.kind;
    data['price'] = this.price;
    data['__v'] = this.iV;
    return data;
  }
}

class Point {
  String? name;
  String? address;
  String? description;

  Point({this.name, this.address, this.description});

  Point.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['description'] = this.description;
    return data;
  }
}
