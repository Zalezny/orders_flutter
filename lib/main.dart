import 'dart:convert';

import 'package:flutter/material.dart';
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
    // onPrimary: const Color(0x00ff5a6e),
    secondary: const Color(0x00e83c65),
    // onSecondary: const Color(0x00ff7392),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KatyaOrders',
      theme: ThemeData(
        colorScheme: schemeOfcolors,
      ),
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

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              bottom: const TabBar(tabs: [
                Tab(
                  text: 'Do wysyłki',
                ),
                Tab(
                  text: 'Wysłane',
                ),
              ]),
            ),
            body: FutureBuilder(
              future: _futureOrder,
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  var _ordersList = snapshot.data!.orders;
                  return TabBarView(
                    children: [
                      OrderPage(ordersList: _ordersList!, isSend: false),
                      OrderPage(ordersList: _ordersList, isSend: true),
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
