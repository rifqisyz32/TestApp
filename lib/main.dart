import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(TestApp());
}

class TestApp extends StatefulWidget {
  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  int counter = 1;

  List<Tab> myTab = [
    Tab(text: "Mapping"),
    Tab(text: "List View"),
    Tab(text: "Grid View"),
    Tab(text: "State"),
  ];

  final List<Map<String, dynamic>> myList = const [
    {
      "Name": "Kamisato Ayaka",
      "Image": "images/FnhcYXYWAAEWoJx.jpeg",
      "Title": "Shirasagi Himegimi",
      "FavColor": ["Blue", "White", "Purple"],
    },
    {
      "Name": "Raiden Ei",
      "Image": "images/FlONSy7aAAEoKNN.jpeg",
      "Title": "Eternity",
      "FavColor": ["Purple", "White", "Black"],
    },
    {
      "Name": "Keqing",
      "Image": "images/FlARvjlaAAEmuDc.jpeg",
      "Title": "Yuheng of Liyue",
      "FavColor": ["Purple", "Black", "Blue"],
    },
    {
      "Name": "Sangonomiya Kokomi",
      "Image": "images/Fpk100tacAA1WbU.jpeg",
      "Title": "The Divine Priestess",
      "FavColor": ["Blue", "Pink", "White", "Purple", "White", "Black"],
    },
  ];

  final List<Container> gridContainer = List.generate(90, (index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256),
            Random().nextInt(256)),
      ),
    );
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
        bodyMedium: TextStyle(fontFamily: 'Montserrat'),
      )),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: 0,
        length: myTab.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Test App"),
            bottom: TabBar(tabs: myTab),
          ),
          body: TabBarView(
            children: [
              ListView(
                children: myList.map((data) {
                  List favColor = data["FavColor"];
                  return Card(
                    margin: EdgeInsets.all(16),
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage("${data['Image']}"),
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${data['Name']}"),
                                  Text("${data['Title']}"),
                                ],
                              )
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: favColor.map((color) {
                                return Container(
                                  color: Colors.blue[300],
                                  margin: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 8),
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    color,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  int noRandom = Random().nextInt(20);
                  return ChatItem(
                      imageUrl: "https://picsum.photos/id/$noRandom/300/300",
                      title: "Kamisato Ayaka",
                      subtitle: "Shirasagi Himegimi");
                },
              ),
              GridView.count(
                padding: EdgeInsets.all(16),
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: gridContainer,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      counter.toString(),
                      style: TextStyle(
                        fontSize: 48,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (counter != 1) {
                                setState(() {
                                  counter--;
                                });
                              }
                              print(counter);
                            },
                            child: Icon(Icons.remove)),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                counter++;
                              });
                              print(counter);
                            },
                            child: Icon(Icons.add))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String imageUrl, title, subtitle;

  ChatItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        subtitle: Text(
          subtitle,
          maxLines: 1,
        ),
        trailing: Text("12:34"),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ));
  }
}
