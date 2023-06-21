import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_app/pages/product_page.dart';
import 'package:test_app/widgets/list_map_widget.dart';

class TabPage extends StatelessWidget {
  static const routeName = '/tab_page';

  final List<Tab> myTab = [
    Tab(text: "Mapping"),
    Tab(text: "Grid View"),
  ];

  final List<Map<String, dynamic>> myMap = const [
    {
      "Name": "Kamisato Ayaka",
      "Image": "assets/images/FnhcYXYWAAEWoJx.jpeg",
      "Title": "Shirasagi Himegimi",
      "FavColor": ["Blue", "White", "Purple"],
    },
    {
      "Name": "Raiden Ei",
      "Image": "assets/images/FlONSy7aAAEoKNN.jpeg",
      "Title": "Eternity",
      "FavColor": ["Purple", "White", "Black"],
    },
    {
      "Name": "Keqing",
      "Image": "assets/images/FlARvjlaAAEmuDc.jpeg",
      "Title": "Yuheng of Liyue",
      "FavColor": ["Purple", "Black", "Blue"],
    },
    {
      "Name": "Sangonomiya Kokomi",
      "Image": "assets/images/Fpk100tacAA1WbU.jpeg",
      "Title": "The Divine Priestess",
      "FavColor": ["Blue", "Pink", "White", "Purple", "White", "Black"],
    },
  ];

  final List<Container> gridContainer = List.generate(
    30,
    (index) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256),
            Random().nextInt(256)),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: myTab.length,
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) => IconButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ProductPage(),
                ),
              ),
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
              ),
            ),
          ),
          title: Text(
            "Tab Page",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            tabs: myTab,
            labelStyle: TextStyle(
              fontFamily: 'SFUIText',
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'SFUIText',
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            listViewMap(mapData: myMap),
            GridView.count(
              padding: EdgeInsets.all(16),
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: gridContainer,
            ),
          ],
        ),
      ),
    );
  }
}
