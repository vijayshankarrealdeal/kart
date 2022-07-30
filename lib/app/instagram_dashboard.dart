import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kart/controller/switch_menu.dart';
import 'package:kart/widget/text.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:kart/controller/instagram_api.dart';

class InstagramDashboard extends StatelessWidget {
  const InstagramDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<API, SwitchMenu>(
      builder: (context, data, meu, _) {
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
                  String like =
                      '${NumberFormat.compact().format(data.data[index].likes)} Likes';
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
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
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        icon:
                                            const Icon(Icons.search, size: 50),
                                        onPressed: () async {
                                          meu.searchCall(data.data[index].id);
                                          await dialogX(context);
                                          //
                                        }),
                                  ],
                                ),
                                Text(
                                  data.data[index].textData['username'],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
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
    );
  }

  Future<void> dialogX(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.black.withOpacity(0.6),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Consumer<SwitchMenu>(builder: (context, menu, _) {
              return AnimatedContainer(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                duration: const Duration(milliseconds: 1200),
                height: menu.load
                    ? MediaQuery.of(context).size.height * 0.3
                    : menu.searchData.isEmpty
                        ? MediaQuery.of(context).size.width * 0.15
                        : MediaQuery.of(context).size.height * 0.98,
                width: menu.load
                    ? MediaQuery.of(context).size.width * 0.3
                    : menu.searchData.isEmpty
                        ? MediaQuery.of(context).size.width * 0.55
                        : MediaQuery.of(context).size.width * 0.85,
                child: menu.load
                    ? const CupertinoActivityIndicator()
                    : menu.searchData.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(CupertinoIcons.clear),
                                ),
                              ),
                              Expanded(
                                child: Text('No Similar Item',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Similar Item on Filpkart",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(CupertinoIcons.clear),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: PageView.builder(
                                    onPageChanged: (x) => menu.pageC(x),
                                    controller: menu.controller,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: menu.searchData.length,
                                    itemBuilder: (context, index) {
                                      return SingleChildScrollView(
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                menu.controller.previousPage(
                                                    duration: const Duration(
                                                        milliseconds: 800),
                                                    curve: Curves.easeIn);
                                              },
                                              icon: const Icon(
                                                  CupertinoIcons.back),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  image: DecorationImage(
                                                      image: NetworkImage(menu
                                                          .searchData[index]
                                                          .img),
                                                      fit: BoxFit.fitHeight),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    menu.searchData[index]
                                                        .title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    '\u{20B9}${menu.searchData[index].price.toString()}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    menu.searchData[index]
                                                        .rating,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                menu.controller.nextPage(
                                                    duration: const Duration(
                                                        milliseconds: 800),
                                                    curve: Curves.easeIn);
                                              },
                                              icon: const Icon(
                                                  CupertinoIcons.forward),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                    "Page ${menu.page + 1} / ${menu.searchData.length}")
                              ],
                            ),
                          ),
              );
            }),
          );
        });
  }
}
