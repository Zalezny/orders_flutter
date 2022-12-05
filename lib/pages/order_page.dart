import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:testapp/utils/const_database.dart';
import 'package:testapp/widgets/order_list_builder.dart';

import '../models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  final bool isSend;

  const OrderPage({super.key, required this.isSend});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List<String> exampleList =
      List<String>.generate(10000, (i) => 'Item $i');

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
  Widget build(BuildContext context) {
    return FutureBuilder<OrderList>(
      future: _futureOrder,
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          var _ordersList = snapshot.data!.orders;
          return OrderListView(ordersList: _ordersList, isSend: widget.isSend);
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
