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
  final Orders selectedOrder;
  final Function swipeArchive;

  SelectedOrderPage({
    super.key,
    required this.selectedOrder,
    required this.swipeArchive,
  });

  @override
  State<SelectedOrderPage> createState() => _SelectedOrderPageState();
}

class _SelectedOrderPageState extends State<SelectedOrderPage> {
  final OrdersConnection ordersConnection = GetIt.I<OrdersConnection>();
  bool _isPayment = false;
  @override
  void initState() {
    _isPayment = widget.selectedOrder.status ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderId = widget.selectedOrder.sId!;

    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              "Zamówienie nr ${widget.selectedOrder.orderNumber.toString()}",
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: widget.selectedOrder.archive!
                  ? const Icon(CupertinoIcons.archivebox_fill)
                  : const Icon(CupertinoIcons.archivebox),
              onPressed: () {
                ordersConnection.patchIsArchive(
                    isArchive: !(widget.selectedOrder.archive!),
                    id: orderId,
                    onSuccess: () {
                      widget.swipeArchive(widget.selectedOrder.sId,
                          !(widget.selectedOrder.archive!));
                      Navigator.of(context).pop(); // its confusing
                    });
              },
            ))
        : AppBar(
            title: Text(
                "Zamówienie nr ${widget.selectedOrder.orderNumber.toString()}"),
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
                initValue: widget.selectedOrder.status,
                text: Text(
                  "Zapłacono",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                onChanged: (newValue) => ordersConnection.patchStatus(
                    status: newValue!,
                    id: widget.selectedOrder.sId!,
                    onSuccess: () => Fluttertoast.showToast(msg: "Pomyślnie zaktualizowano stan zapłaty na $newValue")),
              ),
              widget.selectedOrder.payment != null
                  ? Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.selectedOrder.payment!.method!,
                        style: const TextStyle(color: Colors.black38),
                      ),
                    )
                  : const SizedBox(),
              SelectedOrderCart(selectedOrder: widget.selectedOrder),
              SelectedOrderPersonalInfo(selectedOrder: widget.selectedOrder)
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
              isArchive: widget.selectedOrder.archive!,
              orderId: orderId,
              onPatchSuccess: () {
                widget.swipeArchive(
                    widget.selectedOrder.sId, !(widget.selectedOrder.archive!));
                Navigator.of(context).pop();
              },
            ),
          );
  }
}
