import 'package:flutter/material.dart';

import 'login_button.dart';
import '../../../services/auth_service.dart';

class LoginForm extends StatelessWidget {
  LoginForm(this.setLoadingState, this.emailFieldCtrl, this.passwordFieldCtrl);

  final emailFieldCtrl;
  final passwordFieldCtrl;
  final authService = AuthService();
  final setLoadingState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailFieldCtrl,
            decoration: InputDecoration(
              hintText: 'something@email.com',
              labelText: 'Email',
            ),
          ),
          TextFormField(
            controller: passwordFieldCtrl,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'password',
              labelText: 'Password',
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 24.0)),
          LoginButton(
            text: 'Login',
            onPressed: () async {
              bool _shouldNavigate = await authService
                  .signIn(context, emailFieldCtrl.text, passwordFieldCtrl.text);
              setLoadingState(true);
              if (_shouldNavigate) {
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                setLoadingState(false);
              }
            },
          ),
        ],
      ),
    );
  }
}
