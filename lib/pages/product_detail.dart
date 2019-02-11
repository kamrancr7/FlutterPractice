import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui_elements/TextDefault.dart';

class ProductDetail extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String productDescription;
  final String productPrice;
  final String productAddress;

  ProductDetail(this.title, this.imageUrl, this.productDescription,
      this.productPrice, this.productAddress);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("Back Button Pressed");
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(imageUrl),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextDefault(title),
              ),
              Row(
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
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  productDescription,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Oswald",
                    color: Colors.grey,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
