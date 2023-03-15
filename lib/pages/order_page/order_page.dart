import 'package:flutter/material.dart';
import 'package:testapp/pages/selected_order_page/selected_order_page.dart';
import 'package:testapp/web_api/dto/orders.dart';

class OrderPage extends StatefulWidget {
  final bool isSend;
  final List<Orders> reversedOrdersList;

  const OrderPage(
      {super.key, required this.reversedOrdersList, required this.isSend});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  void _swipeArchiveOrder(String id, bool archiveBool) {
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectedOrderPage(
                            selectedOrder: currItem,
                            swipeArchive: _swipeArchiveOrder,
                          ))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Zamówienie nr ${currItem.orderNumber}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "${currItem.name} ${currItem.lastName}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Divider()
                ],
              ),
            ),
          );
        }
        return const SizedBox(height: 0);
      }),
      itemCount: widget.reversedOrdersList.length,
    );
  }
}
