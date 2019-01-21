import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function product;

  ProductControl(this.product);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        product({"title": "Chocolate", "image": "assets/food.jpg"});
      },
      child: Text("Add Product"),
    );
  }
}
