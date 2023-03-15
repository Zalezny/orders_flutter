import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/web_api/dto/orders.dart';
import '../pages/order_page/order_page.dart';

class CustomTabView extends StatelessWidget {
  final List<Orders> reversedOrdersList;
  Future<void> Function() pullRefresh;
  final int index;

  CustomTabView(
      {super.key,
      required this.reversedOrdersList,
      required this.pullRefresh,
      this.index = 0});

  @override
  Widget build(BuildContext context) {
    final listOfTabs = [
      RefreshIndicator(
        onRefresh: pullRefresh,
        child: OrderPage(reversedOrdersList: reversedOrdersList, isSend: false),
      ),
      RefreshIndicator(
        onRefresh: pullRefresh,
        child: OrderPage(reversedOrdersList: reversedOrdersList, isSend: true),
      ),
    ];

    final dynamic tabView = Platform.isIOS
        ? CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(child: listOfTabs[index]);
            },
          )
        : TabBarView(children: listOfTabs);

    return tabView;
  }
}
