import 'package:flutter/material.dart';

import './components/registration_form.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen(this.cameras);

  final cameras;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: RegistrationForm(cameras),
        ),
      ),
    );
  }
}
