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
}
