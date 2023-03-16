import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get_it/get_it.dart';
import 'package:testapp/web_api/connections/orders_connection.dart';

class SelectedOrderFloatingActionButton extends StatelessWidget {
  final OrdersConnection ordersConnection = GetIt.I<OrdersConnection>();
  final bool isArchive;
  final String orderId;

  SelectedOrderFloatingActionButton({
    super.key,
    required this.isArchive,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => ordersConnection.patchIsArchive(
          isArchive: isArchive,
          id: orderId,
          onSuccess: () {
            Navigator.of(context).pop();
          }),
      icon: Icon(isArchive ? Icons.archive : Icons.unarchive),
      label: Text(isArchive ? 'COFNIJ WYSŁANIE' : 'WYŚLIJ'),
      backgroundColor: Theme.of(context).primaryColorDark,
      foregroundColor: Colors.white,
    );
  }
}
