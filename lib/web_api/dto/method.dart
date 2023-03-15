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
}
