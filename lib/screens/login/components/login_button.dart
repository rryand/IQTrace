import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  LoginButton({required this.text, required this.onPressed});

  final String text;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty
          .resolveWith((states) => Theme.of(context).primaryColor),
        padding: MaterialStateProperty
          .resolveWith((states) => EdgeInsets.symmetric(
            horizontal: 48.0,
            vertical: 12.0,
          ))
      ),
    );
  }
}
