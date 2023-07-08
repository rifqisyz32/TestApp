import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_app/providers/player_provider.dart';

class AddPlayerPage extends StatelessWidget {
  static const routeName = '/add_player_page';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<PlayerProvider>(context, listen: false);

    void addPlayer() {
      player
          .addPlayer(
        nameController.text,
        positionController.text,
        imageController.text,
      )
          .then(
        (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Added Successfully"),
              duration: Duration(seconds: 1),
            ),
          );
          Navigator.pop(context);
        },
      ).catchError(
        (err) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error $err"),
            content: Text("Server Error"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Okay"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Player"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_outlined,
            ),
            onPressed: addPlayer,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Name"),
                textInputAction: TextInputAction.next,
                controller: nameController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Position"),
                textInputAction: TextInputAction.next,
                controller: positionController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Image Url"),
                textInputAction: TextInputAction.next,
                controller: imageController,
                onEditingComplete: addPlayer,
              ),
              SizedBox(
                height: 48,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  child: Text("Submit"),
                  onPressed: addPlayer,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
