import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:orderskatya/web_api/const_database.dart';

class ApiService {
  Map<String, String> headers = {
    'authorization': ConstDatabase.keyAuth,
  };

  Future<Response> get(String uri) async {
    final dio = Dio();
    dio.options.headers.addAll(headers);

    return dio.get(uri);
  }

  Future<Response> patch(String uri, Map<String, String> toPatchData) async {
    final dio = Dio();

    dio.options.headers['Content-Type'] = 'application/json';
    return dio.patch(
      uri,
      data: json.encode(toPatchData),
    );
  }
}
