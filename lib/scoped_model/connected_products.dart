import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  UserModel _authenticatedUser;
  int selIndex;

  void addProduct(String title, String description, double price, String image,
      String address) {
    final Product newProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        address: address,
        id: _authenticatedUser.id,
        email: _authenticatedUser.email);
    _products.add(newProduct);
    notifyListeners();
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavourite = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavourite) {
      return _products.where((Product product) => product.isFavourite).toList();
    }
    return List.from(_products);
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
    return _products[selIndex];
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
    _products[selIndex] = updateProduct;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(selIndex);
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
    _products[selIndex] = updateProduct;
    selIndex = null;
    notifyListeners();
  }

  void selectedProduct(int index) {
    selIndex = index;
    if(index != null) {
      notifyListeners();
    }
  }

  void toggleDisplayMode() {
    _showFavourite = !_showFavourite;
    notifyListeners();
  }
}

mixin UserScoppedModel on ConnectedProductsModel {

  void login(String email, String password) {
    _authenticatedUser = UserModel(id: "1", email: email, password: password);
  }
}