import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testapp/custom_widgets/custom_tab_view.dart';
import 'package:testapp/web_api/connections/orders_connection.dart';
import 'package:testapp/web_api/dto/order_list_dto.dart';

import 'main_cupertino_tab_bar.dart';

class MainFutureBuilder extends StatefulWidget {
  const MainFutureBuilder({super.key});

  @override
  State<MainFutureBuilder> createState() => _MainFutureBuilderState();
}

class _MainFutureBuilderState extends State<MainFutureBuilder> {
  final OrdersConnection ordersConnection = GetIt.I<OrdersConnection>();

  late Future<OrderListDto> _futureOrder;

  @override
  void initState() {
    super.initState();
    _futureOrder = ordersConnection.getOrders();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _futureOrder = ordersConnection.getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? FutureBuilder(
            future: _futureOrder,
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return MainCupertinoTabBar(
                    pullRefresh: _pullRefresh,
                    ordersList: snapshot.data!.orders!);
              } else if (snapshot.hasError) {
                throw Exception(snapshot.error);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        : FutureBuilder(
            future: _futureOrder,
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                var ordersList = snapshot.data!.orders;
                return CustomTabView(
                    reversedOrdersList: ordersList!.reversed.toList(),
                    pullRefresh: _pullRefresh);
              } else if (snapshot.hasError) {
                throw Exception(snapshot.error);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
  }
}
