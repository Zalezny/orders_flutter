import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:testapp/models/order_model.dart';
import 'package:testapp/utils/const_database.dart';
import 'package:testapp/widgets/default_appbar.dart';

class ItemPage extends StatelessWidget {
  final Orders selectedOrder;

  const ItemPage({super.key, required this.selectedOrder});

  @override
  Widget build(BuildContext context) {
    final cart = selectedOrder.order;
    return Scaffold(
      appBar: AppBar(
        title: Text("Zamówienie nr ${selectedOrder.orderNumber.toString()}"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemBuilder: (ctx, index) => Row(children: [
                Image.network(
                  '$https${cart[index].photo}',
                  height: 150,
                  width: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        cart[index].title!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      cart[index].color!.isEmpty
                          ? Text("nie ma kolorku")
                          : Text("jest kolorek")
                    ],
                  ),
                )
              ]),
              itemCount: cart.length,
              shrinkWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
