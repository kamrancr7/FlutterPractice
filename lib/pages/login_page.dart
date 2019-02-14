import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  final Map<String,dynamic> _formData = {
    "email" : null,
    "password" : null,
    "acceptTerms" : false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
        fit: BoxFit.cover,
        image: AssetImage("assets/background.jpg"));
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Email", filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return "Please enter valid email";
        }
      },
      onSaved: (String userValue) {
        _formData["email"] = userValue;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Password", filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length <= 5) {
          return "Password invalid";
        }
      },
      onSaved: (String passwordValue) {
        _formData["password"] = passwordValue;
      },
    );
  }

  Widget _buildSwitch() {
    return SwitchListTile(
      value: _formData["acceptTerms"],
      onChanged: (bool value) {
        setState(() {
          _formData["acceptTerms"] = value;
        });
      },
      title: Text("Accept Terms"),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        decoration: BoxDecoration(image: _buildBackgroundImage()),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildSwitch(),
                    RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text("LOGIN"),
                        onPressed: _onSubmit)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
