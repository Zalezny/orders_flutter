import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/order_model.dart';

class PersonalInfo extends StatelessWidget {
  final Orders selectedOrder;
  const PersonalInfo({super.key, required this.selectedOrder});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Dane do wysyłki: "),
        Text("${selectedOrder.name} ${selectedOrder.lastName}"),
        Text("${selectedOrder.street}"),
        Text("${selectedOrder.postCode} ${selectedOrder.city}"),
        Text("${selectedOrder.phone}"),
        Text("${selectedOrder.email}"),
        selectedOrder.shipment!.point!.address!.isEmpty &&
                selectedOrder.shipment?.point == null
            ? const Text("")
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Paczkomat: "),
                  Text(selectedOrder.shipment!.point!.name!),
                  Text(selectedOrder.shipment!.point!.address!),
                  Text(selectedOrder.shipment!.point!.description!),
                ],
              ),
        const Text("Komentarze: "),
        selectedOrder.comments != null
            ? Text(selectedOrder.comments!)
            : const Text(""),
      ],
    );
  }
}
