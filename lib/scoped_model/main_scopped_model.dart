import 'package:flutter_app/scoped_model/connected_products.dart';
import 'package:scoped_model/scoped_model.dart';

class MainScoppedModel extends Model with ConnectedProductsModel,ProductsModel,UserScoppedModel,UtilityModel{
}