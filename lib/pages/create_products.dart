import 'package:flutter/material.dart';

class CreateProductsPage extends StatefulWidget {
  final Function addProduct;

  CreateProductsPage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _CreateProductsPageState();
  }
}

class _CreateProductsPageState extends State<CreateProductsPage> {
  String _titleValue;
  String _descriptionValue;
  double _priceValue;

  // For Title Text Field
  Widget _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(labelText: "Title"),
      onChanged: (String value) {
        setState(() {
          _titleValue = value;
        });
      },
    );
  }

  // For Description Text Field
  Widget _buildDescriptionTextField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(labelText: "Description"),
      onChanged: (String value) {
        setState(() {
          _descriptionValue = value;
        });
      },
    );
  }

  // For Price Text Field
  Widget _buildPriceTextField() {
    return TextField(
      decoration: InputDecoration(labelText: "Price"),
      onChanged: (String value) {
        setState(() {
          _priceValue = double.parse(value);
        });
      },
      keyboardType: TextInputType.numberWithOptions(decimal: false),
    );
  }

  // For Save button pressed
  void _submitForm(){
    
            final Map<String, dynamic> product = {
              'title': _titleValue,
                'description': _descriptionValue,
                'price': _priceValue,
                'image': 'assets/food.jpg',
                'address': 'Malir Halt, Karachi Pakistan'
            };
            widget.addProduct(product);
            Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildTitleTextField(),
        _buildDescriptionTextField(),
        _buildPriceTextField(),
        SizedBox(
          height: 10.0,
        ),
        RaisedButton(
          child: Text("Save"),
          color: Theme.of(context).accentColor,
          onPressed: _submitForm,
        )
      ],
    );
  }
}
