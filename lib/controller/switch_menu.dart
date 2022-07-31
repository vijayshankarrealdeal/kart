import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:kart/model/search_model.dart';
import 'package:kart/model/top_model.dart';

class SwitchMenu extends ChangeNotifier {
  SwitchMenu() {
    _call();
  }
  Future<void> launchUr(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  bool expand = false;
  void changeX() {
    if (expand == false) {
      expand = true;
    } else {
      expand = false;
    }
    expand != expand;
    notifyListeners();
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
      //
    }
  }

  List<SearchModelFlipkart> searchData = [];
  bool load = false;
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
      //
      load = false;
      notifyListeners();
    }
  }
}
