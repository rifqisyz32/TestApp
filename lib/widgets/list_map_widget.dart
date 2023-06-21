import 'package:flutter/material.dart';

class listViewMap extends StatelessWidget {
  const listViewMap({
    super.key,
    required this.mapData,
  });

  final List<Map<String, dynamic>> mapData;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: mapData.map((data) {
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
