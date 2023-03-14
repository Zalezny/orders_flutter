import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testapp/web_api/const_database.dart';

class ApiService {
  Map<String, String> headers = {
    'authorization': ConstDatabase.keyAuth,
    "Content-Type": "application/json",
  };

  Future<http.Response> get(String uri) async {
    ;
    return http.get(
      Uri.parse(uri),
      headers: headers,
    );
  }

  Future<http.Response> patch(String uri, Map<String, dynamic> toPatchData) async {
    return http.patch(
      Uri.parse(uri),
      headers: headers,
      body: toPatchData,
    );
  }
}

