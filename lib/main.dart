import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/pages/order_page.dart';
import 'package:testapp/utils/const_database.dart';

import 'models/order_model.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ColorScheme schemeOfcolors = ColorScheme.fromSwatch().copyWith(
    primary: const Color.fromRGBO(228, 18, 67, 1),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KatyaOrders',
      theme: ThemeData(
          primarySwatch: Colors.green,
          colorScheme: schemeOfcolors,
          fontFamily: 'Roboto',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                titleMedium: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                titleSmall: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              )),
      home: const MyHomePage(title: 'Zamówienia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<OrderList> _futureOrder;

  @override
  void initState() {
    super.initState();
    _futureOrder = fetchOrders();
  }

  static Future<OrderList> fetchOrders() async {
    const Map<String, String> headers = {'authorization': keyAuth};
    final response = await http.get(
      Uri.parse(orderUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return OrderList.fromJson(body);
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> _pullRefresh() async {
    setState(() {
      _futureOrder = fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
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
            ),
            body: FutureBuilder(
              future: _futureOrder,
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  var ordersList = snapshot.data!.orders;
                  return TabBarView(
                    children: [
                      RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: OrderPage(
                            reversedOrdersList: ordersList!.reversed.toList(),
                            isSend: false),
                      ),
                      RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: OrderPage(
                            reversedOrdersList: ordersList.reversed.toList(),
                            isSend: true),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  throw Exception(snapshot.error);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
      );
}
