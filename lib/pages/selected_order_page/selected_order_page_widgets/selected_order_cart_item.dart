import 'package:flutter/material.dart';
import 'package:orderskatya/web_api/dto/order.dart';

class SelectedOrderCartItem extends StatelessWidget {
  final Order itemCart;
  const SelectedOrderCartItem({super.key, required this.itemCart});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Image.network(
                'https:${itemCart.photo}',
                height: 150,
                width: 100,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      itemCart.title!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: itemCart.color!.isEmpty
                          ? Text(
                              "rozmiar: ${itemCart.size}",
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "kolor: ${itemCart.color}",
                              textAlign: TextAlign.center,
                            ),
                    ),
                    Text("ilość: ${itemCart.quantity}"),
                  ],
                ),
              ),
              Text("${itemCart.price} zł",
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        )
      ],
    );
  }
}
