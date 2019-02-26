import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/scoped_model/products_model.dart';
import 'package:flutter_app/ui_elements/TextDefault.dart';
import 'package:flutter_app/widgets/products/address_tag.dart';
import 'package:scoped_model/scoped_model.dart';
import './price_tag.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextDefault(product.title),
          SizedBox(
            width: 8.0,
          ),
          PriceTag(product.price.toString())
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>(
              context, '/product/' + productIndex.toString()),
        ),
        ScopedModelDescendant<ProductsModel>(
          builder: (BuildContext context, Widget child, ProductsModel model) {
            return IconButton(
              icon: Icon(model.products[productIndex].isFavourite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                model.selectedProduct(productIndex);
                model.toggleProductFavouriteStatus();
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          _buildTitlePriceRow(),
          AddressTag(product.address.toString()),
          _buildActionButtons(context)
        ],
      ),
    );
    ;
  }
}
