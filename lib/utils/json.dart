import 'dart:convert';

import 'package:flutter/services.dart';

class JsonReader {
  

  static Future<List<Map<String, dynamic>>> readJson(String path) async {
    String data = await rootBundle.loadString(path);
    final List<dynamic> listData = jsonDecode(data);
    return listData.cast<Map<String, dynamic>>();
  }
}