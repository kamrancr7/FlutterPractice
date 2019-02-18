import 'package:flutter/material.dart';
import '../widgets/helper/ensure-visible.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formValues = {
    "title": null,
    "description": null,
    "price": null,
    "image": "assets/food.jpg",
    "address": "Malir Halt, Karachi Pakistan"
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  // For Title Text Field
  Widget _buildTitleTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: "Title"),
        initialValue: widget.product == null ? "" : widget.product["title"],
        validator: (String value) {
          if (value.isEmpty || value.length <= 5) {
            return "Title is required and should be 5+ characters long";
          }
        },
        onSaved: (String value) {
          _formValues["title"] = value;
        },
      ),
    );
  }

  // For Description Text Field
  Widget _buildDescriptionTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        maxLines: 4,
        decoration: InputDecoration(labelText: "Description"),
        initialValue:
            widget.product == null ? "" : widget.product["description"],
        validator: (String value) {
          if (value.isEmpty || value.length <= 10) {
            return "Description is required and should be 10+ characters long";
          }
        },
        onSaved: (String value) {
          _formValues["description"] = value;
        },
      ),
    );
  }

  // For Price Text Field
  Widget _buildPriceTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        decoration: InputDecoration(labelText: "Price"),
        initialValue:
            widget.product == null ? "" : widget.product["price"].toString(),
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
            return "Price is required and should be Number";
          }
        },
        onSaved: (String value) {
          _formValues["price"] = double.parse(value);
        },
        keyboardType: TextInputType.numberWithOptions(decimal: false),
      ),
    );
  }

  // For Save button pressed
  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.product == null) {
      widget.addProduct(_formValues);
    } else {
      widget.updateProduct(widget.productIndex, _formValues);
    }
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    final Widget pageContent = GestureDetector(
      onTap: () {
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
      ),
    );
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text("Edit Product"),
            ),
            body: pageContent,
          );
  }
}
