import 'package:flutter/material.dart';
import './pages/product_admin.dart';
import './pages/home_page.dart';
import './pages/product_detail.dart';
import './pages/login_page.dart';

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
  List<Map<String, dynamic>> _products = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.deepOrange, accentColor: Colors.purple),
      // home: LoginPage(),
      routes: {
        "/": (BuildContext) => LoginPage(),
        "/home": (BuildContext) => HomePage(_products),
        "/admin": (BuildContext) => ProductAdmin(_addProduct, _deleteProduct)
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split("/");
        if (pathElements[0] != "") {
          return null;
        }
        if (pathElements[1] == "product") {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductDetail(
                  _products[index]["title"], _products[index]["image"],
                  _products[index]["description"],_products[index]["price"].toString(),
                  _products[index]["address"]));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext) => HomePage(_products));
      },
    );
  }

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }
}
