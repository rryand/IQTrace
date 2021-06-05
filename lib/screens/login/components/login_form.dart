import 'package:flutter/material.dart';

import 'login_button.dart';
import 'package:iq_trace/services/auth_service.dart';

class LoginForm extends StatefulWidget {
  LoginForm(this.emailFieldCtrl, this.passwordFieldCtrl);

  final emailFieldCtrl;
  final passwordFieldCtrl;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isLoading = false;

  Future<void> _signIn(BuildContext context) async {
    final _authService = AuthService();

    setState(() => _isLoading = true);

    bool _shouldNavigate = await _authService
        .signIn(widget.emailFieldCtrl.text, widget.passwordFieldCtrl.text);

    setState(() => _isLoading = false);
    if (_shouldNavigate) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: widget.emailFieldCtrl,
            decoration: InputDecoration(
              hintText: 'something@email.com',
              labelText: 'Email',
            ),
          ),
          TextFormField(
            controller: widget.passwordFieldCtrl,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'password',
              labelText: 'Password',
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 24.0)),
          _isLoading ? CircularProgressIndicator() : LoginButton(
            text: 'Login',
            onPressed: () => _signIn(context),
          ),
        ],
      ),
    );
  }
}
