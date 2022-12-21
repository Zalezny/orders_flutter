import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:testapp/main.dart';
import 'package:testapp/models/order_model.dart';
import 'package:testapp/utils/const_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/cart.dart';
import '../widgets/personal_info.dart';

class ItemPage extends StatelessWidget {
  final Orders selectedOrder;
  final Function swipeArchive;

  const ItemPage(
      {super.key, required this.selectedOrder, required this.swipeArchive});

  void _sendPatchToDatabase(
      {required bool isArchive,
      required String dynamicUrl,
      required VoidCallback onSuccess}) async {
    final property = {'archive': isArchive};
    const Map<String, String> headers = {
      "authorization": keyAuth,
      "Content-Type": "application/json"
    };
    var response = await http.patch(
      Uri.parse(dynamicUrl),
      body: jsonEncode(property),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      Fluttertoast.showToast(
        msg: "Stan zamówienia został zmieniony na $isArchive ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      swipeArchive(selectedOrder.sId, isArchive);
      onSuccess.call(); //call about finish async function (for build context)
    } else {
      throw Exception('Failed to patch, StatusCode: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dynamicUrl = orderUrl + selectedOrder.sId!;
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
                _sendPatchToDatabase(
                    isArchive: !(selectedOrder.archive!),
                    dynamicUrl: dynamicUrl,
                    onSuccess: () {
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
                    onPressed: () => _sendPatchToDatabase(
                        isArchive: false,
                        dynamicUrl: dynamicUrl,
                        onSuccess: () {
                          Navigator.of(context).pop();
                        }),
                    icon: const Icon(Icons.unarchive),
                    label: const Text('COFNIJ WYSŁANIE'),
                    backgroundColor: Theme.of(context).primaryColorDark,
                  )
                : FloatingActionButton.extended(
                    onPressed: () => _sendPatchToDatabase(
                        isArchive: true,
                        dynamicUrl: dynamicUrl,
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
