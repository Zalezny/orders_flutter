import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:testapp/models/order_model.dart';
import 'package:testapp/web_api/const_database.dart';
import 'package:testapp/web_api/services/api_service.dart';

class OrdersConnection {
  final apiService = GetIt.I<ApiService>();

  Future<OrderList> getOrders() async {
    final Response response = await apiService.get(ConstDatabase.orderUrl);
    
    if(response.statusCode == 404)
    {
      throw Exception('Failed load');
    }
    else {
      final body = json.decode(response.body);
      var orders = OrderList.fromJson(body);
      return orders;
    }
  }

  Future<void> patchIsArchive({required bool isArchive, required String id, required VoidCallback onSuccess}) async {
    final body = {'archive': isArchive};
    final Response response = await apiService.patch(ConstDatabase.dynamicOrderUrl(id), body);

    if(response.statusCode == 404) {
      throw Exception('Failed to patch, StatusCode: ${response.statusCode}');
    } else {
      onSuccess.call();
    }
  }
  
}
//   void _sendPatchToDatabase(
//       {required bool isArchive,
//       required String dynamicUrl,
//       required VoidCallback onSuccess}) async {
//     final property = {'archive': isArchive};
//     const Map<String, String> headers = {
//       "authorization": keyAuth,
//       "Content-Type": "application/json"
//     };
//     var response = await http.patch(
//       Uri.parse(dynamicUrl),
//       body: jsonEncode(property),
//       headers: headers,
//     );

//     if (response.statusCode == 200) {
//       print(json.decode(response.body));
//       Fluttertoast.showToast(
//         msg: "Stan zamówienia został zmieniony na $isArchive ",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//       );
//       swipeArchive(selectedOrder.sId, isArchive);
//       onSuccess.call(); //call about finish async function (for build context)
//     } else {
//       throw Exception('Failed to patch, StatusCode: ${response.statusCode}');
//     }
//   }