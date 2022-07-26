import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kart/model/instagram.dart';
import 'package:http/http.dart' as http;

class API extends ChangeNotifier {
  API() {
    _call();
  }
  List<InstagramCall> data = [];

  void _call() async {
    const url = 'http://127.0.0.1:8000/instagram';
    try {
      final res = await http.get(Uri.parse(url));
      data = json
          .decode(res.body)
          .map<InstagramCall>((e) => InstagramCall.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }
  }
}
