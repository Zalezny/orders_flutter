import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:testapp/models/order_model.dart';

import '../widgets/cart.dart';
import '../widgets/personal_info.dart';

class ItemPage extends StatelessWidget {
  final Orders selectedOrder;

  const ItemPage({super.key, required this.selectedOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zamówienie nr ${selectedOrder.orderNumber.toString()}"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Cart(selectedOrder: selectedOrder),
              PersonalInfo(selectedOrder: selectedOrder)
            ],
          ),
        ),
      ),
    );
  }
}
