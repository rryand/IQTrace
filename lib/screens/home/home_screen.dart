import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iq_trace/services/user_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

import './components/user_details.dart';
import './components/iqt_drawer.dart';
import 'components/not_verified.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({required this.title});

  final String title;

  final _userService = UserService.instance;

  @override
  Widget build(BuildContext context) {
    final _isVerified = _userService.currentUser.isVerified;
    print("isVerified: $_isVerified");

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/iqt-icon-black-handle.png',
          height: 55,
        ),
        centerTitle: true,
        actions: _isVerified ? [_buildQrScannerButton(context)] : null,
        leading: _isVerified ? _buildMenuButton() : null,
      ),
      drawer: _isVerified ? IQTDrawer(_userService.currentUser) : null,
      body: Padding(
      padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,  
        ),
        child: _isVerified ? _buildBody(context) : NotVerified(),
      ),
    );
  }

  Widget _buildBody(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_userService.currentUser.faceEncoding!.length == 0)
          _buildEncodingPrompt(context),
        Center(
          child: QrImage(
            data: jsonEncode(_userService.currentUser.debugToJson()),
            size: 280.0,
          ),
        ),
        UserDetails(_userService.currentUser),
      ],
    );
  }

  Widget _buildMenuButton() {
    return Builder(
      builder: (BuildContext context) => IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  Widget _buildQrScannerButton(context) {
    return IconButton(
      icon: Icon(
        Icons.qr_code_scanner,
        size: 30
      ),
      onPressed: () => Navigator.pushNamed(context, '/scanner'),
    );
  }

  Widget _buildEncodingPrompt(context) {
    return ColoredBox(
      color: Colors.red.shade200,
      child: Column(
        children: [
          Text(
            "You have not uploaded your picture for encoding!"
            " Click on the button below to do so."
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
              '/register/camera',
              arguments: {
                'isLoggedIn': true,
                'user': _userService.currentUser,
              },
            ),
            child: Text('Camera')
          ),
        ],
      ),
    );
  }
}
