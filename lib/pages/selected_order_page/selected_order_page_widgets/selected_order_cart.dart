import 'package:flutter/material.dart';
import 'package:testapp/pages/selected_order_page/selected_order_page_widgets/selected_order_cart_item.dart';
import 'package:testapp/web_api/dto/orders.dart';

class SelectedOrderCart extends StatelessWidget {
  final Orders selectedOrder;

  const SelectedOrderCart({super.key, required this.selectedOrder});

  int addAllPrices() {
    int sum = 0;
    for (int i = 0; i < selectedOrder.order.length; i++) {
      sum += selectedOrder.order[i].price!;
    }
    sum += selectedOrder.shipment!.method!.price!;
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final cart = selectedOrder.order;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListView.builder(
            itemBuilder: (ctx, index) =>
                SelectedOrderCartItem(itemCart: cart[index]),
            itemCount: cart.length,
            shrinkWrap: true,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dostawa: ${selectedOrder.shipment?.method?.kind}"),
                Text("${selectedOrder.shipment?.method?.price} zł"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Suma: "),
                Text("${addAllPrices().toString()} zł"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
/**Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Image.network(
                    'https:${cart[index].photo}',
                    height: 150,
                    width: 100,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 8.0, right: 8.0, bottom: 1.0),
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            cart[index].title!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: cart[index].color!.isEmpty
                                          ? Text("rozmiar: ${cart[index].size}")
                                          : Text("kolor: ${cart[index].color}"),
                                    ),
                                    Text("ilość: ${cart[index].quantity}")
                                  ],
                                ),
                              ),
                              Text("${cart[index].price} zł",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
                const Divider(
                  color: Colors.black,
                )
              ],
            ), */
