import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/pages/main_page/main_page_widgets/main_future_builder.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
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