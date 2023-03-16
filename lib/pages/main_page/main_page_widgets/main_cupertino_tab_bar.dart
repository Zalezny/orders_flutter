import 'package:flutter/cupertino.dart';
import 'package:testapp/pages/main_page/main_page_widgets/main_custom_tab_view.dart';
import 'package:testapp/web_api/dto/orders.dart';

class MainCupertinoTabBar extends StatelessWidget {
  final List<Orders> ordersList;
  final Future<void> Function() pullRefresh;

  const MainCupertinoTabBar({
    super.key,
    required this.pullRefresh,
    required this.ordersList,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart),
                label: 'Do wysłania',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chevron_up_square),
                label: 'Wysłane',
              ),
            ],
          ),
          tabBuilder: (ctx, index) => MainCustomTabView(
            reversedOrdersList: ordersList.reversed.toList(),
            pullRefresh: pullRefresh,
            index: index,
          ),
        ),
      ),
    );
  }
}
