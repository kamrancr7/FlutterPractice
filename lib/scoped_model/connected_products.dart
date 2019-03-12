import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  UserModel _authenticatedUser;
  int selIndex;
  String _url = "https://flutter-products-536cd.firebaseio.com/products.json";
  bool _isLoading = false;

  void addProduct(String title, String description, double price, String image,
      String address) {
    _isLoading = true;
    final Map<String, dynamic> productData = {
      "title" : title,
      "description" : description,
      "price" : price,
      "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVjjVX09GA35_3Bg2D1tMWjH6ri8sb7iiiPCsW6ihH0beRQD4DDg",
      "address" : address,
      "email" : _authenticatedUser.email,
      "userId" : _authenticatedUser.id
    };
    http.post(_url,body: json.encode(productData)).then((http.Response response){
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
        id: responseData["name"],
          title: title,
          description: description,
          price: price,
          image: image,
          address: address,
          userId: _authenticatedUser.id,
          email: _authenticatedUser.email);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
    });

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

  void fetchProducts(){
    _isLoading = true;
    http.get(_url).then((http.Response response){
      final List<Product> fetchProductList = [];
      final Map<String, dynamic> productList = json.decode(response.body);
      productList.forEach((String productId, dynamic productData){
        Product product = Product(id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            image: productData['image'],
            address: productData['address'],
            userId:  productData['userId'].toString(),
            email: productData['email']);
        fetchProductList.add(product);
      });
      _products = fetchProductList;
      _isLoading = false;
      notifyListeners();
    });
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

mixin UtilityModel on ConnectedProductsModel{
  bool get isLoading{
    return _isLoading;
  }
}