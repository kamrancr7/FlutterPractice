import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/scoped_model/products_model.dart';
import 'package:flutter_app/ui_elements/TextDefault.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductDetail extends StatelessWidget {

  final int productIndex;

  ProductDetail(this.productIndex);

  Widget _buildAddressPriceRow(String productAddress,String productPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          productAddress,
          style: TextStyle(fontFamily: "Oswald", color: Colors.grey),
        ),
        Text(
          " | ",
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          productPrice + " Rs",
          style: TextStyle(fontFamily: "Oswald", color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      print("Back Button Pressed");
      Navigator.pop(context, false);
      return Future.value(false);
    }, child: ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
          final Product product = model.products[productIndex];
      return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(product.image),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextDefault(product.title),
              ),
              _buildAddressPriceRow(product.address,product.price.toString()),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  product.description,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Oswald",
                    color: Colors.grey,
                  ),
                ),
              )
            ]),
      );
    }));
  }
}
