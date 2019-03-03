import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedProducts extends Model {
  List<Product> products = [];
  UserModel authenticatedUser;
  int selIndex;

  void addProduct(String title, String description, double price, String image,
      String address) {
    final Product newProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        address: address,
        id: authenticatedUser.id,
        email: authenticatedUser.email);
    products.add(newProduct);
    selIndex = null;
    notifyListeners();
  }
}
