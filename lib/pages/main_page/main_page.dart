import 'package:universal_io/io.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orderskatya/firebase/firebase_messaging_service.dart';
import 'package:orderskatya/pages/main_page/main_page_widgets/main_future_builder.dart';
import 'package:orderskatya/web_api/connections/orders_connection.dart';
import '../../services/navigation_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    
    if(FirebaseMessagingService.terminatedId.isNotEmpty) {

      final ordersConnection = GetIt.I<OrdersConnection>();
      ordersConnection.getOrderById(FirebaseMessagingService.terminatedId).then((value) => NavigationService.navigateToSelectedOrder(value, () {}));
      
    }
    return Platform.isIOS
        ? const CupertinoPageScaffold(
            child: MainFutureBuilder(),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Zamówienia"),
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.white,
                    labelStyle: Theme.of(context).primaryTextTheme.titleLarge,
                    tabs: const [
                      Tab(text: 'Do wysyłki'),
                      Tab(text: 'Wysłane'),
                    ]),
              ),
              body: const MainFutureBuilder(),
            ));
  }
}
