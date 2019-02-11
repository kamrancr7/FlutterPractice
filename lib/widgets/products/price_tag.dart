import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget{
  final String price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Text(
                  "\$" + price,
                  style: TextStyle(color: Colors.white),
                ),
              );
  }

}