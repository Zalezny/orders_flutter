import 'package:flutter/material.dart';
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
        if (widget.ordersList[index].archive == widget.isSend) {
          return Card(
            margin: const EdgeInsets.all(16),
            elevation: 3,
            child: Container(
              padding: const EdgeInsets.all(6),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    alignment: Alignment.center,
                    child: Text(
                        "Zamówienie nr ${widget.ordersList[index].orderNumber}"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    alignment: Alignment.center,
                    child: Text(
                        "${widget.ordersList[index].name} ${widget.ordersList[index].lastName}"),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox(height: 0);
      }),
      itemCount: widget.ordersList.length,
    );
  }
}
