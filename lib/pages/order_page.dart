import 'package:flutter/material.dart';
import 'package:testapp/pages/item_page.dart';
import 'package:testapp/utils/const_database.dart';
import '../models/order_model.dart';

class OrderPage extends StatefulWidget {
  final bool isSend;
  final List<Orders> ordersList;

  const OrderPage({super.key, required this.ordersList, required this.isSend});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List<String> exampleList =
      List<String>.generate(10000, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemBuilder: ((context, index) {
        final currItem = widget.ordersList[index];
        if (currItem.archive == widget.isSend) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage("$https${currItem.order[0].photo}"),
            ),
            title: Text(
              "${currItem.name} ${widget.ordersList[index].lastName}",
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
                    builder: (context) => ItemPage(selectedOrder: currItem))),
          );
        }
        return const SizedBox(height: 0);
      }),
      itemCount: widget.ordersList.length,
    );
  }
}
