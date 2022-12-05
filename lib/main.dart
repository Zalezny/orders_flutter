import 'package:flutter/material.dart';
import 'package:testapp/pages/order_page.dart';

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
            body: const TabBarView(
              children: [
                OrderPage(isSend: false),
                OrderPage(isSend: true),
              ],
            )),
      );
}
