import 'package:flutter/material.dart';
import './product_edit.dart';

class MyProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> productList;
  final Function updateProduct, deleteProduct;

  MyProductsPage(this.productList, this.updateProduct, this.deleteProduct);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductEditPage(
                  product: productList[index],
                  updateProduct: updateProduct,
                  productIndex: index,
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(productList[index]["title"]),
          background: Container(color: Colors.red),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              deleteProduct(index);
              // Then show a snackbar!
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(productList[index]["title"] + " dismissed")));
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
                    backgroundImage: AssetImage(productList[index]["image"])),
                title: Text(productList[index]["title"]),
                subtitle: Text("\Rs ${productList[index]["price"].toString()}"),
                trailing: _buildEditButton(context, index),
              ),
              Divider()
            ],
          ),
        );
      },
      itemCount: productList.length,
    );
  }
}
