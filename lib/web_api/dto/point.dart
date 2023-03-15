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
}
