import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testapp/pages/item_page.dart';
import 'package:testapp/utils/const_database.dart';
import '../models/order_model.dart';

class OrderPage extends StatefulWidget {
  final bool isSend;
  final List<Orders> reversedOrdersList;

  const OrderPage(
      {super.key, required this.reversedOrdersList, required this.isSend});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List<String> exampleList =
      List<String>.generate(10000, (i) => 'Item $i');

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
          return Platform.isIOS
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ItemPage(
                                  selectedOrder: currItem,
                                  swipeArchive: _swipeArchiveOrder,
                                ))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Zamówienie nr ${currItem.orderNumber}",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "${currItem.name} ${currItem.lastName}",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                )
              : ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage("$https${currItem.order[0].photo}"),
                  ),
                  title: Text(
                    "${currItem.name} ${widget.reversedOrdersList[index].lastName}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    "Zamówienie nr ${currItem.orderNumber}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  trailing: currItem.newOrder!
                      ? const Icon(Icons.priority_high)
                      : const Icon(null),
                  iconColor: Colors.red,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemPage(
                                selectedOrder: currItem,
                                swipeArchive: _swipeArchiveOrder,
                              ))),
                );
        }
        return const SizedBox(height: 0);
      }),
      itemCount: widget.reversedOrdersList.length,
    );
  }
}
