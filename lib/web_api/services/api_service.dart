import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:orderskatya/web_api/const_database.dart';

class ApiService {
  Map<String, String> headers = {
    'authorization': ConstDatabase.keyAuth,
  };

  Future<http.Response> get(String uri) async {
    
    return http.get(
      Uri.parse(uri),
      headers: headers,
    );
  }

  Future<http.Response> patch(
    
      String uri, Map<String, String> toPatchData) async {
        headers['Content-Type'] = 'application/json';
    return http.patch(
      Uri.parse(uri),
      headers: headers,
      body: json.encode(toPatchData),
    );
  }
}
