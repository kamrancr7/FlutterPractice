import 'package:flutter/material.dart';

class CreateProductsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateProductsPageState();
  }
}

class _CreateProductsPageState extends State<CreateProductsPage> {
  String titleValue;
  String descriptionValue;
  double priceValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (String value) {
            setState(() {
              titleValue = value;
            });
          },
        ),
        TextField(
          onChanged: (String value) {
            setState(() {
              descriptionValue = value;
            });
          },
        ),
        TextField(
          onChanged: (String value) {
            setState(() {
              priceValue = double.parse(value);
            });
          },
          keyboardType: TextInputType.numberWithOptions(decimal: false),
        )
      ],
    );
  }
}
