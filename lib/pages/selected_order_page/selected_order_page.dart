import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:orderskatya/custom_widgets/custom_checkbox_list_tile.dart';
import 'package:orderskatya/pages/selected_order_page/selected_order_page_widgets/selected_order_floating_action_button.dart';
import 'package:orderskatya/web_api/connections/orders_connection.dart';
import 'package:orderskatya/web_api/dto/orders.dart';
import 'selected_order_page_widgets/selected_order_cart.dart';
import 'selected_order_page_widgets/selected_order_personal_info.dart';

class SelectedOrderPage extends StatefulWidget {
  Orders? selectedOrder;
  Function swipeArchive;
  String? id;

  SelectedOrderPage({
    super.key,
    required this.selectedOrder,
    required this.swipeArchive,
  });
  SelectedOrderPage.fromId({
    super.key,
    required this.id,
    required this.swipeArchive,
  });

  @override
  State<SelectedOrderPage> createState() => _SelectedOrderPageState();
}

class _SelectedOrderPageState extends State<SelectedOrderPage> {
  final OrdersConnection ordersConnection = GetIt.I<OrdersConnection>();
  late final Orders simpleOrder;
  bool _isPayment = false;
  @override
  void initState() {
    if (widget.id != null) {
      ordersConnection
          .getOrderById(widget.id!)
          .then((order) => simpleOrder = order);
    } else {
      simpleOrder = widget.selectedOrder!;
    }
    _isPayment = simpleOrder.status ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderId = simpleOrder.sId!;

    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              "Zamówienie nr ${simpleOrder.orderNumber.toString()}",
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: simpleOrder.archive!
                  ? const Icon(CupertinoIcons.archivebox_fill)
                  : const Icon(CupertinoIcons.archivebox),
              onPressed: () {
                ordersConnection.patchIsArchive(
                    isArchive: !(simpleOrder.archive!),
                    id: orderId,
                    onSuccess: () {
                      widget.swipeArchive(
                          simpleOrder.sId, !(simpleOrder.archive!));
                      Navigator.of(context).pop(); // its confusing
                    });
              },
            ))
        : AppBar(
            title: Text("Zamówienie nr ${simpleOrder.orderNumber.toString()}"),
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
              CustomCheckboxListTile(
                initValue: simpleOrder.status,
                text: Text(
                  "Zapłacono",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                onChanged: (newValue) => ordersConnection.patchStatus(
                    status: newValue!,
                    id: simpleOrder.sId!,
                    onSuccess: () => Fluttertoast.showToast(
                        msg:
                            "Pomyślnie zaktualizowano stan zapłaty na $newValue")),
              ),
              simpleOrder.payment != null
                  ? Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        simpleOrder.payment!.method!,
                        style: const TextStyle(color: Colors.black38),
                      ),
                    )
                  : const SizedBox(),
              SelectedOrderCart(selectedOrder: simpleOrder),
              SelectedOrderPersonalInfo(selectedOrder: simpleOrder),
              const SizedBox(
                height: 60,
              ),
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
              isArchive: simpleOrder.archive!,
              orderId: orderId,
              onPatchSuccess: () {
                widget.swipeArchive(simpleOrder.sId, !(simpleOrder.archive!));
                Navigator.of(context).pop();
              },
            ),
          );
  }
}
