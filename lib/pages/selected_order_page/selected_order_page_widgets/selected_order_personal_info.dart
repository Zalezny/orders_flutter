import 'package:flutter/material.dart';
import 'package:testapp/web_api/dto/orders.dart';

class SelectedOrderPersonalInfo extends StatelessWidget {
  final Orders selectedOrder;
  const SelectedOrderPersonalInfo({super.key, required this.selectedOrder});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Dane do wysyłki: ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text("${selectedOrder.name} ${selectedOrder.lastName}"),
        Text("${selectedOrder.street}"),
        Text("${selectedOrder.postCode} ${selectedOrder.city}"),
        Text("${selectedOrder.phone}"),
        Text("${selectedOrder.email}"),
        selectedOrder.shipment!.point!.name!.isEmpty
            ? const SizedBox(
                height: 0,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Paczkomat: "),
                  Text(selectedOrder.shipment!.point!.name!),
                  Text(selectedOrder.shipment!.point!.address!),
                  Text(selectedOrder.shipment!.point!.description!),
                ],
              ),
        const Text(
          "Komentarze: ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        selectedOrder.comments!.isNotEmpty
            ? Text(selectedOrder.comments!)
            : const Text("brak komentarza"),
      ],
    );
  }
}
