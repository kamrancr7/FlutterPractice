import 'package:flutter/material.dart';
import './pages/product_detail.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;
  Products(this.products, {this.deleteProduct});

  Widget _productBuilder(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]["image"]),
          Text(products[index]["title"]),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  child: Text("Details"),
                  onPressed: () {
                    Navigator
                        .pushNamed<bool>(
                      context,"/product/" + index.toString()
                    )
                        .then((bool value) {
                      if (value) {
                        deleteProduct(index);
                      }
                    });
                  })
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    Widget productCard;
    if (products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: _productBuilder,
        itemCount: products.length,
      );
    } else {
      productCard = Center(
        child: Text("No Product Found please add some"),
      );
    }
    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}
