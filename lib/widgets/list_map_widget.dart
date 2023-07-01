import 'package:flutter/material.dart';

class MapWidget extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: myMap.map((data) {
        List favColor = data["FavColor"];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.pinkAccent,
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
                        Text(
                          "${data['Name']}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${data['Title']}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: favColor.map((color) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.pink[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
    );
  }
}
