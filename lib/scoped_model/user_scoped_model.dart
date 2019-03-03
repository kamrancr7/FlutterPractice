import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/scoped_model/connected_products.dart';

class UserScoppedModel extends ConnectedProducts {

  void login(String email, String password) {
    authenticatedUser = UserModel(id: "1", email: email, password: password);
  }
}
