import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


import '../model/get.dart';

class NetworkRequest {
  static const String url = 'http://103.95.197.177:3010/api/v1/news/all';
  static List<Data> parseGet(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Data> gets = list.map((model) => Data.fromJson(model)).toList();
    return gets;
  }
  static Future<List<Data>?> fetchGets() async {
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    Get foodNews = Get.fromJson(body);

    if (response.statusCode == 200) {
      return foodNews.data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
      // if(response.statusCode == 200) {
      //   return compute(parseGet, response.body);
      // } else if(response.statusCode == 404){
      //   throw Exception('Not Found');
      // } else{
      //   throw Exception('Can\'t get post');
      // }
    }
  }
}