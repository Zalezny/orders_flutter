import 'package:flutter/material.dart';
import 'package:orderskatya/pages/selected_order_page/selected_order_page_widgets/selected_order_cart_item.dart';
import 'package:orderskatya/web_api/dto/orders.dart';

class SelectedOrderCart extends StatelessWidget {
  final Orders selectedOrder;

  const SelectedOrderCart({super.key, required this.selectedOrder});

  double addAllPrices() {
    double sum = 0;
    for (int i = 0; i < selectedOrder.order.length; i++) {
      sum += selectedOrder.order[i].price! * selectedOrder.order[i].quantity!;
    }
    sum += selectedOrder.shipment!.method!.price!;
    return sum;
  }

  double discountPrice() {
    if (selectedOrder.discount != null) {
      return addAllPrices() - selectedOrder.discount!.totalDiscountPrice!;
    }
    return addAllPrices();
  }

  @override
  Widget build(BuildContext context) {
    final cart = selectedOrder.order;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) => SelectedOrderCartItem(itemCart: cart[index]),
            itemCount: cart.length,
            shrinkWrap: true,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dostawa: ${selectedOrder.shipment?.method?.kind}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "${selectedOrder.shipment?.method?.price} zł",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          if (selectedOrder.discount != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kwota: ",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "${addAllPrices().toString()} zł",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          if (selectedOrder.discount != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rabat: ",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "-${selectedOrder.discount!.totalDiscountPrice} zł",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Suma: ",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "${discountPrice().toString()} zł",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
