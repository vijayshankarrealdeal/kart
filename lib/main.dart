import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kart/app/instagram_dashboard.dart';
import 'package:kart/controller/instagram_api.dart';
import 'package:kart/controller/search_api.dart';
import 'package:kart/controller/switch_menu.dart';
import 'package:kart/widget/text.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData _buildTheme(brightness) {
      var baseTheme = ThemeData(brightness: brightness);

      return baseTheme.copyWith(
        textTheme: GoogleFonts.openSansTextTheme(baseTheme.textTheme),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SwitchMenu()),
        ChangeNotifierProvider(create: (ctx) => API()),
        ChangeNotifierProvider(create: (ctx) => SearchApi()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(Brightness.dark),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SwitchMenu>(builder: (context, menu, _) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: const BoxDecoration(
                color: CupertinoColors.black,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(
                            "Search Trends",
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: Colors.white),
                          ),
                          onPressed: () => menu.change(MenuItems.searchTrends),
                        ),
                        const SizedBox(width: 10),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(
                            "Instagram",
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: Colors.white),
                          ),
                          onPressed: () => menu.change(MenuItems.instagram),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: menu.load
                          ? const CupertinoActivityIndicator()
                          : const SizedBox.shrink(),
                    ),
                  ]),
            ),
            Expanded(child: menu.changedisplay()),
          ],
        );
      }),
    );
  }
}
