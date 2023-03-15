import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/web_api/dto/orders.dart';
import '../pages/order_page/order_page.dart';

class CustomTabView extends StatefulWidget {
  final List<Orders> reversedOrdersList;
  Future<void> Function() pullRefresh;
  final int index;

  CustomTabView(
      {super.key,
      required this.reversedOrdersList,
      required this.pullRefresh,
      this.index = 0});

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  @override
  Widget build(BuildContext context) {
    final listOfTabs = [
      RefreshIndicator(
        onRefresh: widget.pullRefresh,
        child: OrderPage(reversedOrdersList: widget.reversedOrdersList, isSend: false),
      ),
      RefreshIndicator(
        onRefresh: widget.pullRefresh,
        child: OrderPage(reversedOrdersList: widget.reversedOrdersList, isSend: true),
      ),
    ];

    final dynamic tabView = Platform.isIOS
        ? CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(child: listOfTabs[widget.index]);
            },
          )
        : TabBarView(children: listOfTabs);

    return tabView;
  }
}
