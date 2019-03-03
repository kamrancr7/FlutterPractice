import 'package:flutter_app/scoped_model/connected_products.dart';
import 'package:flutter_app/scoped_model/products_model.dart';
import 'package:flutter_app/scoped_model/user_scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MainScoppedModel extends Model with ConnectedProducts,ProductsModel,UserScoppedModel{

}