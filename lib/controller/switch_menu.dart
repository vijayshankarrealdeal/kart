import 'package:flutter/cupertino.dart';
import 'package:kart/app/instagram_dashboard.dart';
import 'package:kart/app/search_trends.dart';

enum MenuItems { searchTrends, instagram, flipkart }

class SwitchMenu extends ChangeNotifier {
  MenuItems items = MenuItems.searchTrends;

  void change(item) {
    items = item;
    notifyListeners();
  }

  Widget changedisplay() {
    if (items == MenuItems.flipkart) {
      return Container();
    }
    if (items == MenuItems.instagram) {
      return const InstagramDashboard();
    }
    return const SearchTrends();
  }
}
