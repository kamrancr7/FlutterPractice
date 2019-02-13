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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // For Title Text Field
  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Title"),
      //autovalidate: true,
      validator: (String value){
        if(value.isEmpty || value.length <= 5){
          return "Title is required and should be 5+ characters long";
        }
      },
      onSaved: (String value) {
          _titleValue = value;
      },
    );
  }

  // For Description Text Field
  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(labelText: "Description"),
      validator: (String value){
        if(value.isEmpty || value.length <= 10){
          return "Description is required and should be 10+ characters long";
        }
      },
      onSaved: (String value) {
          _descriptionValue = value;
      },
    );
  }

  // For Price Text Field
  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Price"),
      validator: (String value){
        if(value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)){
          return "Price is required and should be Number";
        }
      },
      onSaved: (String value) {
          _priceValue = double.parse(value);
      },
      keyboardType: TextInputType.numberWithOptions(decimal: false),
    );
  }

  // For Save button pressed
  void _submitForm() {
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
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
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
      margin: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
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
        ),
      ),
    ),);
  }
}
