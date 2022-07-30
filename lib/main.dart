import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kart/app/instagram_dashboard.dart';
import 'package:kart/controller/api.dart';
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
        ChangeNotifierProvider(create: (ctx) => API()),
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
      body: InstagramDashboard(),
    );
  }
}
