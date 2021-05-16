import 'package:flutter/material.dart';

import 'login_button.dart';

class UserAccountForm extends StatelessWidget {
  UserAccountForm({
    required this.emailController,
    required this.passwordController,
    required this.buttonText,
    required this.buttonOnPressed,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String buttonText;
  final buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'something@email.com',
            labelText: 'Email',
          ),
        ),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'password',
            labelText: 'Password',
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 24.0)),
        LoginButton(
          text: buttonText,
          onPressed: buttonOnPressed,
        ),
      ],
    );
  }
}
