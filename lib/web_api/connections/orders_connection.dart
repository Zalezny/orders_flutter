import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:testapp/web_api/dto/order_list_dto.dart';
import 'package:testapp/web_api/const_database.dart';
import 'package:testapp/web_api/services/api_service.dart';

class OrdersConnection {
  final apiService = GetIt.I<ApiService>();

  Future<OrderListDto> getOrders() async {
    final Response response = await apiService.get(ConstDatabase.ordersUrl);
    
    if(response.statusCode == 404)
    {
      throw Exception('Failed load');
    }
    else {
      final body = json.decode(response.body);
      var orders = OrderListDto.fromJson(body);
      return orders;
    }
  }

  Future<void> patchIsArchive({required bool isArchive, required String id, required VoidCallback onSuccess}) async {
    final Map<String,String> body = {'archive': isArchive.toString()};
    final Response response = await apiService.patch(ConstDatabase.dynamicOrderUrl(id), body);

    if(response.statusCode == 404) {
      throw Exception('Failed to patch, StatusCode: ${response.statusCode}');
    } else {
      onSuccess.call();
    }
  }
  
}
