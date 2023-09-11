import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:orderskatya/web_api/const_database.dart';

class ApiService {
  Map<String, String> headers = {
    'authorization': ConstDatabase.keyAuth,
  };

  Future<http.Response> get(String authority, String path ) async {
    
    return http.get(
      Uri.https(authority, path),
      headers: headers,
    );
  }

  Future<http.Response> patch(
    
      String uri, Map<String, String> toPatchData) async {
        headers['Content-Type'] = 'application/json';
    return http.patch(
      Uri.https(uri),
      headers: headers,
      body: json.encode(toPatchData),
    );
  }
}
