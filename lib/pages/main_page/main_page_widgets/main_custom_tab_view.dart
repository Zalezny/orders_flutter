import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderskatya/providers/terminated_message_provider.dart';
import 'package:orderskatya/services/navigation_service.dart';
import 'package:orderskatya/web_api/dto/orders.dart';
import 'package:provider/provider.dart';
import '../../orders_page/orders_page.dart';

class MainCustomTabView extends StatefulWidget {
  final List<Orders> reversedOrdersList;
  final Future<void> Function() pullRefresh;
  final int index;

  const MainCustomTabView(
      {super.key,
      required this.reversedOrdersList,
      required this.pullRefresh,
      this.index = 0});

  @override
  State<MainCustomTabView> createState() => _MainCustomTabViewState();
}

class _MainCustomTabViewState extends State<MainCustomTabView> {
  @override
  Widget build(BuildContext context) {
    final listOfTabs = [
      RefreshIndicator(
        onRefresh: widget.pullRefresh,
        child: OrdersPage(
            reversedOrdersList: widget.reversedOrdersList, isSend: false),
      ),
      RefreshIndicator(
        onRefresh: widget.pullRefresh,
        child: OrdersPage(
            reversedOrdersList: widget.reversedOrdersList, isSend: true),
      ),
    ];

    return Platform.isIOS
        ? CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(child: listOfTabs[widget.index]);
            },
          )
        : TabBarView(children: listOfTabs);
    
  }
}
