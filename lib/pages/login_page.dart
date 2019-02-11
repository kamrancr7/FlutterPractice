import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  String _userName;
  String _password;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: AssetImage("assets/background.jpg"))),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: "Email",
                      filled: true,
                      fillColor: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String userValue) {
                    setState(() {
                      _userName = userValue;
                    });
                  },
                ),
                SizedBox(height: 10.0,),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Password",
                      filled: true,
                      fillColor: Colors.white),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onChanged: (String passwordValue) {
                    setState(() {
                      _password = passwordValue;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                SwitchListTile(
                  value: _switchValue,
                  onChanged: (bool value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                  title: Text("State Change"),
                ),
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text("LOGIN"),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/home");
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
