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

  Future<void> _floatingButtonPressed(User user, String imagePath, bool isLoggedIn) async {
    final _userService = UserService.instance;
    setState(() => isLoading = true);

    ApiResponse<void> response = await _userService.uploadFaceImage(user.email!, imagePath);

    switch (response.status) {
      case Status.COMPLETED:
        Navigator.pushNamedAndRemoveUntil(
          context, isLoggedIn ? '/home' : '/login', (Route<dynamic> route) => false);
        
        if (isLoggedIn) {
          _userService.currentUser.faceEncoding = [1];
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image encoding is successfull!'))
        );
        break;
      case Status.ERROR:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => 
              ErrorScreen(
                errorMessage: "Error! Account has been created but something "
                  + "went wrong with image upload. Please login and try again.",
                onRetryPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, isLoggedIn ? '/home' : '/login', (Route<dynamic> route) => false)
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
    final bool _isLoggedIn = _arguments['isLoggedIn'] != null ? 
      _arguments['isLoggedIn'] : 
      false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Display Image'),
      ),
      floatingActionButton: FloatingActionButton(
        child: isLoading ? CircularProgressIndicator() : Icon(Icons.save_alt),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async => await _floatingButtonPressed(
          _user, _imagePath, _isLoggedIn),
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
