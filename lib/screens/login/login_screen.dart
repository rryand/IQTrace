import 'package:flutter/material.dart';

import 'components/login_header.dart';
import 'components/login_form.dart';

class LoginScreen extends StatelessWidget {
  final emailFieldCtrl = TextEditingController();
  final passwordFieldCtrl = TextEditingController();

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
            LoginForm(emailFieldCtrl, passwordFieldCtrl),
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
