import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kart/app/instagram_dashboard.dart';
import 'package:kart/app/search_trends.dart';
import 'package:http/http.dart' as http;
import 'package:kart/model/search_model.dart';

enum MenuItems { searchTrends, instagram }

class SwitchMenu extends ChangeNotifier {
  MenuItems items = MenuItems.searchTrends;

  List<SearchModelFlipkart> searchData = [];
  bool load = false;
  bool firstPage = false;
  bool lastPage = false;
  int page = 0;
  void pageC(int x) {
    page = x;
    notifyListeners();
  }

  late PageController controller;

  void searchCall(String photoname) async {
    load = true;
    page = 0;
    controller = PageController(initialPage: 0);
    notifyListeners();

    final queryParameters = {'photoname': photoname};
    final uri = Uri.http('127.0.0.1:8000', '/getsimilaritem', queryParameters);
    try {
      final response = await http.get(uri);
      searchData = json
          .decode(response.body)
          .map<SearchModelFlipkart>((e) => SearchModelFlipkart.fromJson(e))
          .toList();
      load = false;
      notifyListeners();
    } catch (e) {
      print(e);
      load = false;
      notifyListeners();
    }
  }

  void change(item) {
    items = item;
    notifyListeners();
  }

  Widget changedisplay() {
    if (items == MenuItems.instagram) {
      return const InstagramDashboard();
    }
    return const SearchTrends();
  }
}
