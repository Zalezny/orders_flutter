import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/web_api/dto/orders.dart';
import '../pages/orders_page/orders_page.dart';

class CustomTabView extends StatefulWidget {
  final List<Orders> reversedOrdersList;
  final Future<void> Function() pullRefresh;
  final int index;

  const CustomTabView(
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
        child: OrdersPage(reversedOrdersList: widget.reversedOrdersList, isSend: false),
      ),
      RefreshIndicator(
        onRefresh: widget.pullRefresh,
        child: OrdersPage(reversedOrdersList: widget.reversedOrdersList, isSend: true),
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
