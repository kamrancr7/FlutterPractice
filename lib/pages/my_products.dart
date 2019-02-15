import 'package:flutter/material.dart';

class MyProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> productList;

  MyProductsPage(this.productList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          //leading: Image.asset(productList[index]["image"]),
          title: Text(productList[index]["title"]),
          trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
        );
      },
      itemCount: productList.length,
    );
  }
}
