import 'orders.dart';

class OrderListDto {
  final List<Orders>? orders;

  OrderListDto({required this.orders});
  factory OrderListDto.fromJson(List<dynamic> json) {
    List<Orders> orders = json.map((i) => Orders.fromJson(i)).toList();
    return OrderListDto(orders: orders);
  }
}
