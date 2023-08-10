class Discount {
  String? code;
  int? totalDiscountPrice;

  Discount({this.code, this.totalDiscountPrice});

  Discount.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    totalDiscountPrice = json['totalDiscountPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['totalDiscountPrice'] = totalDiscountPrice;
    return data;
  }
}