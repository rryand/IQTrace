import 'package:flutter/material.dart';

import './components/login_header.dart';
import '../../components/user_account_form.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final authService = new AuthService();

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
                  UserAccountForm(
                    emailController: _emailField,
                    passwordController: _passwordField,
                    buttonText: 'Login',
                    buttonOnPressed: () {},
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 12.0)),
            Text('No account yet?'),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: Text('Register')
            ),
          ],
        ),
      ),
    );
  }
}
