import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:testapp/main.dart';
import 'package:testapp/models/order_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testapp/web_api/connections/orders_connection.dart';

import '../widgets/cart.dart';
import '../widgets/personal_info.dart';

class ItemPage extends StatelessWidget {
  final Orders selectedOrder;
  final Function swipeArchive;
  final OrdersConnection ordersConnection = GetIt.I<OrdersConnection>();

  ItemPage(
      {super.key, required this.selectedOrder, required this.swipeArchive,});

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
                      swipeArchive(selectedOrder.sId, !(selectedOrder.archive!));
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
              Cart(selectedOrder: selectedOrder),
              PersonalInfo(selectedOrder: selectedOrder)
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
            floatingActionButton: selectedOrder.archive!
                ? FloatingActionButton.extended(
                    onPressed: () => ordersConnection.patchIsArchive(
                        isArchive: false,
                        id: orderId,
                        onSuccess: () {
                          Navigator.of(context).pop();
                        }),
                    icon: const Icon(Icons.unarchive),
                    label: const Text('COFNIJ WYSŁANIE'),
                    backgroundColor: Theme.of(context).primaryColorDark,
                  )
                : FloatingActionButton.extended(
                    onPressed: () => ordersConnection.patchIsArchive(
                        isArchive: true,
                        id: orderId,
                        onSuccess: () {
                          Navigator.of(context).pop(); // its confusing
                        }),
                    icon: const Icon(Icons.archive),
                    label: const Text('WYŚLIJ'),
                    backgroundColor: Theme.of(context).primaryColorDark,
                    foregroundColor: Colors.white,
                  ));
  }
}
