import 'package:flutter/material.dart';
import 'package:flutter_app/scoped_model/main_scopped_model.dart';
import '../widgets/products/products.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  final MainScoppedModel model;

  HomePage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Choose"),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Products"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/admin");
            },
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainScoppedModel model) {
        Widget content = Center(
          child: Text("No Product Found"),
        );
        if (model.displayedProducts.length > 0 && !model.isLoading) {
          content = Products();
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator(),);
        }
        return RefreshIndicator(child: content, onRefresh: model.fetchProducts);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text("EasyList"),
        actions: <Widget>[
          ScopedModelDescendant<MainScoppedModel>(
            builder:
                (BuildContext context, Widget child, MainScoppedModel model) {
              return IconButton(
                icon: Icon(model.showFavourite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          )
        ],
      ),
      body: _buildProductList(),
    );
  }
}
