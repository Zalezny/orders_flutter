import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:testapp/widgets/order_item.dart';

class OrderList extends StatefulWidget {
  final bool isSend;

  const OrderList(this.isSend);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final List<String> exampleList =
      List<String>.generate(10000, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        return OrderItem(
          index: index,
          context: context,
          exampleList: exampleList,
        );
      }),
      itemCount: exampleList.length,
    );
  }
}
