import 'package:flutter/material.dart';
import 'package:orderskatya/pages/selected_order_page/selected_order_page.dart';
import 'package:orderskatya/web_api/dto/orders.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Future<void> navigateToSelectedOrder(Orders order, Function swipeArchive) async {
    navigatorKey.currentState!.push(MaterialPageRoute(
      builder: (context) => SelectedOrderPage(
        selectedOrder: order,
        swipeArchive: swipeArchive,
      ),
    ));
  }
  static Future<void> navigateToSelectedOrderById(String id) async {
    navigatorKey.currentState!.push(MaterialPageRoute(
      builder: (context) => SelectedOrderPage.fromId(id: id.replaceAll(r'"', ''), swipeArchive: () {},),
    ));
  }
}
