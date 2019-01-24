import 'package:flutter/material.dart';
import './home_page.dart';

class ProductAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text("Product Admin"),
            ),
            ListTile(
              title: Text("Go Back"),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext) => HomePage()));
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Product Admin"),
      ),
      body: Center(child: Text("Welcome to Product Admin Page")),
    );
  }
}
