import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Consumer<API>(
        builder: (context, data, _) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: GradinentTextGive(
                  text: "Instagram",
                  colors: [
                    Color(0xff515BD4),
                    Color(0xffF58529),
                    Color(0xffFEDA77),
                    Color(0xffDD2A7B),
                    Color(0xff8134AF),
                  ],
                  fontSize: 100,
                ),
              ),
              const SliverPadding(padding: EdgeInsets.all(20)),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    String imageId =
                        'http://127.0.0.1:8000/files/${data.data[index].id}.jpg';
                    String likes = data.data[index].textData['likes'];
                    String like = likes.contains("Be the") ? "0 Likes" : likes;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                imageId,
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.25,
                            left: 18.0,
                            right: 18.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        like,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                      const Icon(Icons.search, size: 50),
                                    ],
                                  ),
                                  Text(
                                    data.data[index].textData['username'],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: ListView(
                                      children:
                                          data.data[index].textData['hastag']
                                              .map<Widget>(
                                                (e) => Text(
                                                  e,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: data.data.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
