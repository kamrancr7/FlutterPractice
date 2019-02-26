import 'package:flutter_app/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedIndex;

  List<Product> get products {
    return List.from(_products);
  }

  int get selectedProductId {
    return _selectedIndex;
  }

  Product get selectProduct {
    if (_selectedIndex == null) {
      return null;
    }
    return _products[_selectedIndex];
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedIndex = null;
  }

  void updateProduct(Product product) {
    _products[_selectedIndex] = product;
    _selectedIndex = null;
  }

  void deleteProduct() {
    _products.removeAt(_selectedIndex);
    _selectedIndex = null;
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
        isFavourite: newFavouriteStatus);
    _products[_selectedIndex] = updateProduct;
    _selectedIndex = null;
    notifyListeners();
  }

  void selectedProduct(int index) {
    _selectedIndex = index;
  }
}
