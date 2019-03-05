import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/scoped_model/main_scopped_model.dart';
import './product_card.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
    Widget productCard;
    if (products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
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
    return ScopedModelDescendant<MainScoppedModel>(
        builder: (BuildContext context, Widget child, MainScoppedModel model) {
      return _buildProductList(model.displayedProducts);
    });
  }
}
