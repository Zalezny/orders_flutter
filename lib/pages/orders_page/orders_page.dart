import 'package:flutter/material.dart';
import 'package:testapp/pages/orders_page/orders_page_widgets/orders_list_item.dart';
import 'package:testapp/web_api/dto/orders.dart';

class OrdersPage extends StatefulWidget {
  final bool isSend;
  final List<Orders> reversedOrdersList;

  const OrdersPage(
      {super.key, required this.reversedOrdersList, required this.isSend});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  void swipeArchiveOrder(String id, bool archiveBool) {
    final index =
        widget.reversedOrdersList.indexWhere((element) => element.sId == id);
    var obj = widget.reversedOrdersList[index];
    obj.archive = archiveBool;
    widget.reversedOrdersList.removeAt(index);
    setState(() {
      widget.reversedOrdersList.insert(index, obj);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        final currItem = widget.reversedOrdersList[index];

        if (currItem.archive == widget.isSend) {
          return OrdersItem(
            orderItem: currItem,
            swipeArchiveOrder: swipeArchiveOrder,
          );
        }
        return const SizedBox(height: 0);
      }),
      itemCount: widget.reversedOrdersList.length,
    );
  }
}
