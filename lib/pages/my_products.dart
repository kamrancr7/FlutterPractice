import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/scoped_model/products_model.dart';
import 'package:scoped_model/scoped_model.dart';
import './product_edit.dart';

class MyProductsPage extends StatelessWidget {
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
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.products[index].title),
              background: Container(color: Colors.red),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectedProduct(index);
                  model.deleteProduct();
                  // Then show a snackbar!
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content:
                          Text(model.products[index].title + " dismissed")));
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
                            AssetImage(model.products[index].image)),
                    title: Text(model.products[index].title),
                    subtitle:
                        Text("\Rs ${model.products[index].price.toString()}"),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.products.length,
        );
      },
    );
  }
}
