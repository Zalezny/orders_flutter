import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testapp/di/dependency_injection.dart';
import 'package:testapp/utils/utils.dart';
import 'package:testapp/web_api/connections/orders_connection.dart';
import 'package:testapp/custom_widgets/custom_tab_view.dart';
import 'package:testapp/custom_widgets/custom_app.dart';

import 'web_api/dto/order_list_dto.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    setupDependencyInjection();
  }

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CustomApp();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    final dynamic appBar = AppBar(
      title: Text(widget.title),
      bottom: TabBar(tabs: [
        Tab(
          child: Text(
            'Do wysyłki',
            style: Theme.of(context).primaryTextTheme.titleLarge,
          ),
        ),
        Tab(
          child: Text(
            'Wysłane',
            style: Theme.of(context).primaryTextTheme.titleLarge,
          ),
        ),
      ]),
    );

    final bodyPage = Platform.isIOS
        ? CupertinoPageScaffold(
            child: FutureBuilder(
                future: _futureOrder,
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    var ordersList = snapshot.data!.orders;
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoTabScaffold(
                          tabBar: CupertinoTabBar(
                              items: const <BottomNavigationBarItem>[
                                BottomNavigationBarItem(
                                    icon: Icon(CupertinoIcons.cart),
                                    label: 'Do wysłania'),
                                BottomNavigationBarItem(
                                    icon:
                                        Icon(CupertinoIcons.chevron_up_square),
                                    label: 'Wysłane'),
                              ]),
                          tabBuilder: (ctx, index) => CustomTabView(
                            reversedOrdersList: ordersList!.reversed.toList(),
                            pullRefresh: _pullRefresh,
                            index: index,
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    throw Exception(snapshot.error);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: appBar,
                body: FutureBuilder(
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
                )),
          );

    return bodyPage;
  }
}
