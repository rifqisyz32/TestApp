import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:test_app/pages/players/add_player_page.dart';
import 'package:test_app/pages/players/detail_player_page.dart';
import 'package:test_app/providers/player_provider.dart';

class PlayerPage extends StatefulWidget {
  static const routeName = '/player_page';

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<PlayerProvider>(context).initialData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Player Page"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AddPlayerPage.routeName),
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: (playerProvider.countPlayer == 0)
          ? SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No data",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  OutlinedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AddPlayerPage.routeName),
                    child: Text(
                      "Add Player",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: playerProvider.countPlayer,
              itemBuilder: (context, index) {
                var id = playerProvider.allPlayer[index].id;

                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) =>
                      playerProvider.deletePlayer(id).then(
                    (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Delete Successfully"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  confirmDismiss: (direction) => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Delete this item?"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text(
                                  "Yes",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.pink,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(
                      right: 16,
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    onTap: () => Navigator.pushNamed(
                      context,
                      DetailPlayerPage.routeName,
                      arguments: id,
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        playerProvider.allPlayer[index].imageUrl,
                      ),
                    ),
                    title: Text(playerProvider.allPlayer[index].name),
                    subtitle: Text(playerProvider.allPlayer[index].position),
                    trailing: Text(
                      DateFormat.jm()
                          .format(playerProvider.allPlayer[index].createdAt),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
