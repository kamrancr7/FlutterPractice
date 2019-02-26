import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/scoped_model/products_model.dart';
import './pages/product_admin.dart';
import './pages/home_page.dart';
import './pages/product_detail.dart';
import './pages/login_page.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProductsModel>(
        model: ProductsModel(),
        child: MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.deepOrange, accentColor: Colors.purple),
          // home: LoginPage(),
          routes: {
            "/": (BuildContext) => LoginPage(),
            "/home": (BuildContext) => HomePage(),
            "/admin": (BuildContext) => ProductAdmin()
          },
          onGenerateRoute: (RouteSettings settings) {
            final List<String> pathElements = settings.name.split("/");
            if (pathElements[0] != "") {
              return null;
            }
            if (pathElements[1] == "product") {
              final int index = int.parse(pathElements[2]);
              return MaterialPageRoute<bool>(
                  builder: (BuildContext context) =>
                      ProductDetail(index));
            }
            return null;
          },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(builder: (BuildContext) => HomePage());
          },
        ));
  }
}
