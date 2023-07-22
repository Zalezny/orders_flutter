import 'package:flutter/material.dart';
import 'package:orderskatya/custom_widgets/text_with_margin.dart';
import 'package:orderskatya/web_api/dto/orders.dart';

class SelectedOrderPersonalInfo extends StatelessWidget {
  final Orders selectedOrder;
  const SelectedOrderPersonalInfo({super.key, required this.selectedOrder});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineSmall;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWithMargin(
          "Dane do wysyłki: ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          top: 4,
        ),
        TextWithMargin(
          "${selectedOrder.name} ${selectedOrder.lastName}",
          style: textStyle,
          top: 4,
        ),
        TextWithMargin(
          "${selectedOrder.street}",
          style: textStyle,
          top: 4,
        ),
        TextWithMargin(
          "${selectedOrder.postCode} ${selectedOrder.city}",
          style: textStyle,
          top: 4,
        ),
        TextWithMargin(
          "${selectedOrder.phone}",
          style: textStyle,
          top: 4,
        ),
        TextWithMargin(
          "${selectedOrder.email}",
          style: textStyle,
          top: 4,
        ),
        selectedOrder.shipment!.point!.name!.isEmpty
            ? const SizedBox(
                height: 0,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWithMargin(
                    "Paczkomat: ",
                    style: textStyle,
                    top: 4,
                  ),
                  TextWithMargin(
                    selectedOrder.shipment!.point!.name!,
                    style: textStyle,
                    top: 4,
                  ),
                  TextWithMargin(
                    selectedOrder.shipment!.point!.address!,
                    style: textStyle,
                    top: 4,
                  ),
                  TextWithMargin(
                    selectedOrder.shipment!.point!.description!,
                    style: textStyle,
                    top: 4,
                  ),
                ],
              ),
        const Text(
          "Komentarze: ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        selectedOrder.comments!.isNotEmpty
            ? Text(
                selectedOrder.comments!,
                style: textStyle,
              )
            : Text(
                "brak komentarza",
                style: textStyle,
              ),
      ],
    );
  }
}
