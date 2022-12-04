import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  BuildContext context;
  int index;
  List<String> exampleList;
  bool isSend;

  OrderItem(
      {super.key,
      required this.index,
      required this.context,
      required this.exampleList,
      required this.isSends});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(6),
        alignment: Alignment.center,
        child: Text("Item ${exampleList[index]}"),
      ),
    );
  }
}
