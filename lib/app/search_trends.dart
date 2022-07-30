import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kart/controller/search_api.dart';
import 'package:provider/provider.dart';

class SearchTrends extends StatelessWidget {
  const SearchTrends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List xx = ["hello", "jello", "sello"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Consumer<SearchApi>(builder: (context, search, _) {
        return Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "trends+",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.2,
                    fontFamily: GoogleFonts.squarePeg().fontFamily,
                  ),
            ),
            AnimatedContainer(
              height: 50,
              duration: const Duration(milliseconds: 1000),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: CupertinoSearchTextField(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ListView.builder(
                itemCount: search.data.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Chip(
                    label: Text(search.data[index].itemName),
                  ),
                ),
                scrollDirection: Axis.horizontal,
              ),
            )
          ],
        );
      }),
    );
  }
}
