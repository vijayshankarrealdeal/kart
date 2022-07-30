import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:kart/model/top_model.dart';

class SearchApi extends ChangeNotifier {
  SearchApi() {
    _call();
  }
  List<TopTrendings> data = [];
  void _call() async {
    const url = 'http://127.0.0.1:8000/trends';
    try {
      final res = await http.get(Uri.parse(url));
      data = json
          .decode(res.body)
          .map<TopTrendings>((e) => TopTrendings.fromJson(e))
          .toList();
      data.sort((a, b) => b.famous.compareTo(a.famous));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
