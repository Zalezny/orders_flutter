// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// import '../models/order_model.dart';

// class OrderBuilderItem extends StatelessWidget {
//   List<Orders> orders;


//   OrderBuilderItem({super.key, orders});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile()
//   }
// }
// Container(
//             alignment: Alignment.center,
//             margin: const EdgeInsets.symmetric(vertical: 10),
//             child: Container(
//               padding: const EdgeInsets.all(2),
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.all(2),
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 5),
//                       child: Text(
//                         "Zamówienie nr ${widget.ordersList[index].orderNumber}",
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 2),
//                       child: Text(
//                         "${widget.ordersList[index].name} ${widget.ordersList[index].lastName}",
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                     ),
//                     Divider(
//                       color: Colors.grey,
//                       indent: BorderSide.strokeAlignOutside,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//         return const SizedBox(height: 0);
//       }),