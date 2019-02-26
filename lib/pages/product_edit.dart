import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/scoped_model/products_model.dart';
import '../widgets/helper/ensure-visible.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductEditPage extends StatefulWidget {
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
  Widget _buildTitleTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: "Title"),
        initialValue: product == null ? "" : product.title,
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
  Widget _buildDescriptionTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        maxLines: 4,
        decoration: InputDecoration(labelText: "Description"),
        initialValue: product == null ? "" : product.description,
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
  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        decoration: InputDecoration(labelText: "Price"),
        initialValue: product == null ? "" : product.price.toString(),
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

  Widget _buildSubmitButton() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return RaisedButton(
        child: Text("Save"),
        color: Theme.of(context).accentColor,
        onPressed: () => _submitForm(model.addProduct, model.updateProduct,model.selectedProductId),
      );
    });
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
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
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  // For Save button pressed
  void _submitForm(Function addProduct, Function updateProduct,[int selectedIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedIndex == null) {
      addProduct(Product(
          address: _formValues["address"],
          description: _formValues["description"],
          image: _formValues["image"],
          price: _formValues["price"],
          title: _formValues["title"]));
    } else {
      updateProduct(
          Product(
              address: _formValues["address"],
              description: _formValues["description"],
              image: _formValues["image"],
              price: _formValues["price"],
              title: _formValues["title"]));
    }
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      final Widget pageContent =
          _buildPageContent(context, model.selectProduct);
      return model.selectedProductId == null
          ? pageContent
          : Scaffold(
              appBar: AppBar(
                title: Text("Edit Product"),
              ),
              body: pageContent,
            );
    });
  }
}
