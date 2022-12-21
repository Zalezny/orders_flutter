import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/pages/order_page.dart';
import 'package:testapp/utils/const_database.dart';
import 'package:testapp/utils/utils.dart';
import 'package:testapp/widgets/custom_tab_view.dart';

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
    return Platform.isIOS
        ? const CupertinoApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            title: 'Flutter Demo',
            theme: CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: Color.fromARGB(255, 255, 0, 60),
              // textTheme: CupertinoTextThemeData(
              //     navActionTextStyle:
              //         TextStyle(color: Color.fromARGB(255, 255, 0, 60)),
              //     textStyle: TextStyle(
              //         color: CupertinoColors.black,
              //         decorationColor: Color.fromARGB(255, 255, 0, 60)))
            ),
            home: MyHomePage(title: 'Home Page'),
          )
        : MaterialApp(
            title: 'KatyaOrders',
            theme: ThemeData(
                primarySwatch: createMaterialColor(const Color(0x00e94168)),
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
      var returnValue = OrderList.fromJson(body);
      return returnValue;
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
