import 'package:cached_network_image/cached_network_image.dart';
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

    void editPlayer() {
      player
          .editPlayer(playerId, nameController.text, positionController.text,
              imageUrlController.text)
          .then(
            (value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Edited Success"),
                duration: Duration(seconds: 1),
              ),
            ),
          );
      Navigator.pop(context);
    }

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
                  borderRadius: BorderRadius.circular(160),
                  child: CachedNetworkImage(
                    height: 240,
                    width: 240,
                    fit: BoxFit.cover,
                    imageUrl: imageUrlController.text,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930"),
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
                  onEditingComplete: editPlayer,
                ),
                SizedBox(
                  height: 48,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    onPressed: editPlayer,
                    child: Text("Edit"),
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
