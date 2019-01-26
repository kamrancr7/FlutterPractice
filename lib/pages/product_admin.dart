import 'package:flutter/material.dart';
import './home_page.dart';
import './create_products.dart';
import './my_products.dart';

class ProductAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text("Product Admin"),
              ),
              ListTile(
                title: Text("Go Back"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Product Admin"),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              icon: Icon(Icons.create),
              text: "Create Products",
            ),
            Tab(
              icon: Icon(Icons.list),
              text: "My Products",
            )
          ]),
        ),
        body: TabBarView(
            children: <Widget>[CreateProductsPage(), MyProductsPage()]),
      ),
    );
  }
}
