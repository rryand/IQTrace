import 'package:flutter/material.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/screens/error/error_screen.dart';

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

    //ApiResponse response = await _authService
    //  .signIn(widget.emailFieldCtrl.text, widget.passwordFieldCtrl.text);

    // TODO: Remove
    final ApiResponse response = await _authService
      .signIn('ramsesryandineros@gmail.com', 'hunter2');

    setState(() => _isLoading = false);

    switch (response.status) {
      case Status.COMPLETED:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case Status.ERROR:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => 
              ErrorScreen(
                errorMessage: response.message!,
                onRetryPressed: () => Navigator.pop(context)
              ),
          )
        );
        break;
      case Status.LOADING:
      default:
        break;
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
            //controller: widget.emailFieldCtrl,
            decoration: InputDecoration(
              hintText: 'yourname@email.com',
              labelText: 'Email',
            ),
            initialValue: 'ramsesryandineros@gmail.com', // TODO: remove
          ),
          TextFormField(
            //controller: widget.passwordFieldCtrl,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'password',
              labelText: 'Password',
            ),
            initialValue: 'hunter2', // TODO: remove
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
