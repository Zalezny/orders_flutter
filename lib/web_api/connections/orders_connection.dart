import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:orderskatya/web_api/const_database.dart';
import 'package:orderskatya/web_api/dto/order_list_dto.dart';
import 'package:orderskatya/web_api/dto/orders.dart';
import 'package:orderskatya/web_api/services/api_service.dart';

class OrdersConnection {
  final apiService = GetIt.I<ApiService>();

  Future<OrderListDto> getOrders() async {
    print(ConstDatabase.ordersUrl);
    final Response response = await apiService.get(ConstDatabase.ordersUrl);

    if (response.statusCode == 404) {
      throw Exception('Failed load');
    } else {
      var orders = OrderListDto.fromJson(response.data);
      return orders;
    }
  }

  Future<Orders> getOrderById(String id) async {
    final String clearId = id.replaceAll(RegExp(r'"'), '');
    final Response response = await apiService.get(ConstDatabase.dynamicOrderUrl(clearId));

    if (response.statusCode == 404) {
      throw Exception('Failed load');
    } else {
      return Orders.fromJson(response.data);
    }
  }

  Future<void> patchIsArchive({required bool isArchive, required String id, required VoidCallback onSuccess}) async {
    final Map<String, String> body = {
      'archive': isArchive.toString(),
    };
    final link = ConstDatabase.dynamicOrderUrl(id);
    final Response response = await apiService.patch(link, body);

    if (response.statusCode == 404) {
      throw Exception('Failed to patch, StatusCode: ${response.statusCode}');
    } else {
      onSuccess.call();
    }
  }

  Future<void> patchStatus({required bool status, required String id, required VoidCallback onSuccess}) async {
    final Map<String, String> body = {
      'status': status.toString(),
    };
    final link = ConstDatabase.dynamicPaymentUrl(id);
    final Response response = await apiService.patch(link, body);

    if (response.statusCode == 404) {
      throw Exception('Failed to patch, StatusCode: ${response.statusCode}');
    } else {
      onSuccess.call();
    }
  }

  Future<void> patchNew({required bool isNew, required String id, required VoidCallback onSuccess}) async {
    final Map<String, String> body = {
      'newOrder': isNew.toString(),
    };
    final link = ConstDatabase.dynamicOrderUrl(id);
    final Response response = await apiService.patch(link, body);

    if (response.statusCode == 404) {
      throw Exception('Failed to patch, StatusCode: ${response.statusCode}');
    } else {
      onSuccess.call();
    }
  }
}
