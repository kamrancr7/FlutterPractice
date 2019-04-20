import 'package:flutter/material.dart';
import 'package:flutter_app/scoped_model/connected_products.dart';
import 'package:flutter_app/scoped_model/main_scopped_model.dart';
import 'package:scoped_model/scoped_model.dart';
import './product_edit.dart';

class MyProductsPage extends StatefulWidget {

  final MainScoppedModel model;

  MyProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _MyProductPage();
  }
}

class _MyProductPage extends State<MyProductsPage>{

  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildEditButton(
      BuildContext context, int index, ProductsModel model) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          model.selectedProduct(index);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductEditPage();
              },
            ),
          ).then((_){
            model.selectedProduct(null);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScoppedModel>(
      builder: (BuildContext context, Widget child, MainScoppedModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.allProducts[index].title),
              background: Container(color: Colors.red),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectedProduct(index);
                  model.deleteProduct();
                  // Then show a snackbar!
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content:
                          Text(model.allProducts[index].title + " dismissed")));
                } else if (direction == DismissDirection.startToEnd) {
                  Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text("Not delete")));
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(model.allProducts[index].image)),
                    title: Text(model.allProducts[index].title),
                    subtitle:
                        Text("\Rs ${model.allProducts[index].price.toString()}"),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.allProducts.length,
        );
      },
    );
  }
}

