import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orderskatya/web_api/connections/orders_connection.dart';

class SelectedOrderFloatingActionButton extends StatelessWidget {
  final OrdersConnection ordersConnection = GetIt.I<OrdersConnection>();
  final bool isArchive;
  final String orderId;
  final Function() onPatchSuccess;

  SelectedOrderFloatingActionButton({
    super.key,
    required this.isArchive,
    required this.orderId,
    required this.onPatchSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => ordersConnection.patchIsArchive(
        isArchive: !(isArchive),
        id: orderId,
        onSuccess: onPatchSuccess,
      ),
      icon: Icon(isArchive ? Icons.archive : Icons.unarchive),
      label: Text(isArchive ? 'COFNIJ WYSŁANIE' : 'WYŚLIJ'),
      backgroundColor: Theme.of(context).primaryColorDark,
      foregroundColor: Colors.white,
    );
  }
}
