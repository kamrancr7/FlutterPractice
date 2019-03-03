import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/scoped_model/connected_products.dart';

class ProductsModel extends ConnectedProducts {
  bool _showFavourite = false;

  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavourite) {
      return products.where((Product product) => product.isFavourite).toList();
    }
    return List.from(products);
  }

  int get selectedProductId {
    return selIndex;
  }

  bool get showFavourite{
    return _showFavourite;
  }

  Product get selectProduct {
    if (selIndex == null) {
      return null;
    }
    return products[selIndex];
  }

  void updateProduct(String title, String description, double price, String image,
      String address) {
    final Product updateProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        address: address,
        id: selectProduct.id,
        email: selectProduct.email);
    products[selIndex] = updateProduct;
    selIndex = null;
  }

  void deleteProduct() {
    products.removeAt(selIndex);
    selIndex = null;
  }

  void toggleProductFavouriteStatus() {
    final bool isCurrentlyFavourite = selectProduct.isFavourite;
    final bool newFavouriteStatus = !isCurrentlyFavourite;
    final Product updateProduct = Product(
        title: selectProduct.title,
        description: selectProduct.description,
        price: selectProduct.price,
        image: selectProduct.image,
        address: selectProduct.address,
        email: selectProduct.email,
        id: selectProduct.id,
        isFavourite: newFavouriteStatus);
    products[selIndex] = updateProduct;
    selIndex = null;
    notifyListeners();
  }

  void selectedProduct(int index) {
    selIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavourite = !_showFavourite;
    notifyListeners();
  }
}
