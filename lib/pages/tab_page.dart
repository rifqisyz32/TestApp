import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_app/pages/products/product_page.dart';

import 'package:test_app/widgets/list_map_widget.dart';

class TabPage extends StatelessWidget {
  static const routeName = '/tab_page';

  final List<Tab> myTab = [
    Tab(text: "Mapping"),
    Tab(text: "Grid View"),
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
          title: Text("Tab Page"),
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
            MapWidget(),
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
