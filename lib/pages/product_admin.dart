import 'package:flutter/material.dart';
import 'package:flutter_app/scoped_model/main_scopped_model.dart';
import './product_edit.dart';
import './my_products.dart';

class ProductAdmin extends StatelessWidget {

  final MainScoppedModel model;

  ProductAdmin(this.model);

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Product Admin"),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Go Back"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/home");
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildDrawer(context),
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
        body: TabBarView(children: <Widget>[
          ProductEditPage(),
          MyProductsPage(model)
        ]),
      ),
    );
  }
}
