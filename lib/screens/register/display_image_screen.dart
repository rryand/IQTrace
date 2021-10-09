import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/services/auth_service.dart';

class DisplayImageScreen extends StatefulWidget {
  @override
  _DisplayImageScreenState createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  bool isLoading = false;

  Future<void> _floatingButtonPressed(User user, String password, String imagePath) async {
    // TODO: register
    /* final auth = AuthService.instance;
    setState(() => isLoading = true);
  
    try {
      await auth.register(user, password);
      await auth.signIn(user.email!, password);
      await auth.updateFaceEncoding(imagePath);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('ERROR: ${e.toString()}')));
    }

    setState(() => isLoading = false);
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', (Route<dynamic> route) => false); */
  }

  @override
  Widget build(BuildContext context) {
    final _arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final User _user = _arguments['user'];
    final String _password = _arguments['password'];
    final String _imagePath = _arguments['imagePath'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Display Image'),
      ),
      floatingActionButton: FloatingActionButton(
        child: isLoading ? CircularProgressIndicator() : Icon(Icons.save_alt),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async => await _floatingButtonPressed(_user, _password, _imagePath),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          child: Image.file(File(_imagePath)),
        ),
      ),
    );
  }
}
