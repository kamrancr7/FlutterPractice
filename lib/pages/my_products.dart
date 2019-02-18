import 'package:flutter/material.dart';
import './product_edit.dart';

class MyProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> productList;
  final Function updateProduct;

  MyProductsPage(this.productList, this.updateProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          //leading: Image.asset(productList[index]["image"]),
          title: Text(productList[index]["title"]),
          trailing: IconButton(
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
              }),
        );
      },
      itemCount: productList.length,
    );
  }
}
