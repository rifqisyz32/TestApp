import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_app/providers/player_provider.dart';

class DetailPlayerPage extends StatelessWidget {
  static const routeName = '/detail_player_page';

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<PlayerProvider>(context, listen: false);
    final playerId = ModalRoute.of(context)?.settings.arguments as String;
    final selectPlayer = player.selectById(playerId);

    final TextEditingController nameController =
        TextEditingController(text: selectPlayer.name);
    final TextEditingController positionController =
        TextEditingController(text: selectPlayer.position);
    final TextEditingController imageUrlController =
        TextEditingController(text: selectPlayer.imageUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Player Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(96),
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        image: NetworkImage(imageUrlController.text),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                  textInputAction: TextInputAction.next,
                  controller: nameController,
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Position",
                  ),
                  textInputAction: TextInputAction.next,
                  controller: positionController,
                ),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Image Url",
                  ),
                  textInputAction: TextInputAction.next,
                  controller: imageUrlController,
                  onEditingComplete: () {
                    player
                        .editPlayer(playerId, nameController.text,
                            positionController.text, imageUrlController.text)
                        .then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Edited Success"),
                              duration: Duration(seconds: 1),
                            ),
                          ),
                        );
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 48,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    onPressed: () {
                      player
                          .editPlayer(playerId, nameController.text,
                              positionController.text, imageUrlController.text)
                          .then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Edited Success"),
                                duration: Duration(seconds: 1),
                              ),
                            ),
                          );
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
