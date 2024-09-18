import 'dart:convert';
import 'package:flutter/services.dart';

class Config {
  static String? googleClientId;

  static Future<void> loadConfig() async {
    final String response = await rootBundle.loadString('assets/config.json');
    final data = json.decode(response);
    googleClientId = data['googleClientId'];
  }
}
