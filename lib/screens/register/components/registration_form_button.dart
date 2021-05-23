import 'package:flutter/material.dart';

class RegistrationFormButton extends StatelessWidget {
  RegistrationFormButton({required this.onPressed, required this.text});

  final onPressed;
  final text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty
            .resolveWith((states) => Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}