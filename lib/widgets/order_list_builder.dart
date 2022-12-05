import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

import '../models/order_model.dart';

class OrderListView extends StatelessWidget {
  List<Orders> ordersList;
  bool isSend;

  OrderListView({super.key, required this.ordersList, required this.isSend});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemBuilder: ((context, index) {
        if (ordersList[index].archive == isSend) {
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
                    child:
                        Text("Zamówienie nr ${ordersList[index].orderNumber}"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    alignment: Alignment.center,
                    child: Text(
                        "${ordersList[index].name} ${ordersList[index].lastName}"),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox(height: 0);
      }),
      itemCount: ordersList.length,
    );
  }
}
