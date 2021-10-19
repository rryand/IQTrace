import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/screens/error/error_screen.dart';
import 'package:iq_trace/services/user_service.dart';

class DisplayImageScreen extends StatefulWidget {
  @override
  _DisplayImageScreenState createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  bool isLoading = false;

  Future<void> _floatingButtonPressed(User user, String imagePath) async {
    final _userService = UserService.instance;
    setState(() => isLoading = true);

    ApiResponse<void> response = await _userService.uploadFaceImage(user.email!, imagePath);

    switch (response.status) {
      case Status.COMPLETED:
        Navigator.pushNamedAndRemoveUntil(
          context, '/login', (Route<dynamic> route) => false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image encoding is successfull!'))
        );
        break;
      case Status.ERROR:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => 
              ErrorScreen(
                errorMessage: response.message!,
                onRetryPressed: () => Navigator.of(context)
                  .popUntil(ModalRoute.withName('/register/camera'))
              ),
          )
        );
        setState(() => isLoading = false);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final User _user = _arguments['user'];
    final String _imagePath = _arguments['imagePath'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Display Image'),
      ),
      floatingActionButton: FloatingActionButton(
        child: isLoading ? CircularProgressIndicator() : Icon(Icons.save_alt),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async => await _floatingButtonPressed(_user, _imagePath),
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
