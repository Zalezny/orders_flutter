import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orderskatya/pages/main_page/main_page_widgets/main_custom_tab_view.dart';
import 'package:orderskatya/web_api/connections/orders_connection.dart';
import 'package:orderskatya/web_api/dto/order_list_dto.dart';

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
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _futureOrder = ordersConnection.getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? FutureBuilder(
            key: ValueKey(_futureOrder),
            future: _futureOrder,
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return MainCupertinoTabBar(pullRefresh: _pullRefresh, ordersList: snapshot.data!.orders!);
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
                return MainCustomTabView(reversedOrdersList: ordersList!.reversed.toList(), pullRefresh: _pullRefresh);
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
