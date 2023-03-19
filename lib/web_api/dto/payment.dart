class Payment {
  int? id;
  String? method;
  Payment({this.id,this.method});
  Payment.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    method = json['method'];
  }
}