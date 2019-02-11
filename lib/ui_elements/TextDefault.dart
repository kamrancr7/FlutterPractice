import 'package:flutter/material.dart';

class TextDefault extends StatelessWidget{
  final String title;

  TextDefault(this.title); 

  @override
  Widget build(BuildContext context) {
    return Text(
                title,
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Oswald"),
              );
  }

}