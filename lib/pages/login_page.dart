import 'package:flutter/material.dart';
import './home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: RaisedButton(
            child: Text("LOGIN"),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext) => HomePage()));
            }),
      ),
    );
  }
}
