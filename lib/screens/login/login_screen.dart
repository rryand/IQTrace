import 'package:flutter/material.dart';

import './components/login_header.dart';
import './components/login_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: _screenWidth,
        height: _screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginHeader(
              width: _screenWidth,
              height: _screenHeight,
            ),
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailField,
                    decoration: InputDecoration(
                      hintText: 'something@email.com',
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    controller: _passwordField,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'password',
                      labelText: 'Password',
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 24.0)),
                  LoginButton(
                    text: 'Login',
                    onPressed: () {},
                  ),
                  Padding(padding: EdgeInsets.only(top: 12.0)),
                  Text('No account yet?'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Register')
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
