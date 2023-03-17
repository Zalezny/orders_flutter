import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:testapp/pages/selected_order_page/selected_order_page_widgets/selected_order_floating_action_button.dart';
import 'package:testapp/web_api/connections/orders_connection.dart';
import 'package:testapp/web_api/dto/orders.dart';
import 'selected_order_page_widgets/selected_order_cart.dart';
import 'selected_order_page_widgets/selected_order_personal_info.dart';

class SelectedOrderPage extends StatelessWidget {
  final Orders selectedOrder;
  final Function swipeArchive;
  final OrdersConnection ordersConnection = GetIt.I<OrdersConnection>();

  SelectedOrderPage({
    super.key,
    required this.selectedOrder,
    required this.swipeArchive,
  });

  @override
  Widget build(BuildContext context) {
    final orderId = selectedOrder.sId!;

    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              "Zamówienie nr ${selectedOrder.orderNumber.toString()}",
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: selectedOrder.archive!
                  ? const Icon(CupertinoIcons.archivebox_fill)
                  : const Icon(CupertinoIcons.archivebox),
              onPressed: () {
                ordersConnection.patchIsArchive(
                    isArchive: !(selectedOrder.archive!),
                    id: orderId,
                    onSuccess: () {
                      swipeArchive(
                          selectedOrder.sId, !(selectedOrder.archive!));
                      Navigator.of(context).pop(); // its confusing
                    });
              },
            ))
        : AppBar(
            title:
                Text("Zamówienie nr ${selectedOrder.orderNumber.toString()}"),
          );

    final pageBody = SingleChildScrollView(
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              SelectedOrderCart(selectedOrder: selectedOrder),
              SelectedOrderPersonalInfo(selectedOrder: selectedOrder)
            ],
          ),
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SelectedOrderFloatingActionButton(
              isArchive: selectedOrder.archive!,
              orderId: orderId,
              onPatchSuccess: () {
                swipeArchive(selectedOrder.sId, !(selectedOrder.archive!));
                Navigator.of(context).pop();
              },
            ),
          );
  }
}
