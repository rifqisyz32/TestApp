import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_app/pages/products/product_page.dart';
import 'package:test_app/providers/product_provider.dart';

class ListPage extends StatelessWidget {
  static const routeName = '/list_page';

  @override
  Widget build(BuildContext context) {
    final allProduct = Provider.of<ProductProvider>(context).allProduct;

    return Scaffold(
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
        title: Text("List Page"),
      ),
      body: ListView.builder(
        itemCount: allProduct.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            confirmDismiss: (direction) => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Konfirmasi"),
                      content: Text("Yakin ingin menghapus?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(
                            "Batal",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(
                            "Ya",
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
            child: ChatItem(
              allProduct[index].imageUrl,
              allProduct[index].name,
              allProduct[index].description,
            ),
          );
        },
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  @required
  final String imageUrl, title, subtitle;

  ChatItem(
    this.imageUrl,
    this.title,
    this.subtitle,
  );

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(title),
        subtitle: Text(
          subtitle,
          maxLines: 1,
        ),
        trailing: Text(
          "12:34",
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
      );
}
