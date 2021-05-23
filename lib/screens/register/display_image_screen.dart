import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/services/file_service.dart';

class DisplayImageScreen extends StatefulWidget {
  @override
  _DisplayImageScreenState createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  bool isLoading = false;

  Future<void> _floatingButtonPressed(IQTUser user,String password, String imagePath) async {
    final _fileService = FileService();

    setState(() => isLoading = true);

    user.localImagePath = await _fileService.moveToAppDocs(File(imagePath), 'user_image');
    await _fileService.saveUser(user.toJson());
    bool _isRegistered = await user.save(context, password);

    setState(() => isLoading = false);

    if (_isRegistered) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/home', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final IQTUser _user = _arguments['user'];
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
