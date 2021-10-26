import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/screens/home/components/admin_prompt.dart';
import 'package:iq_trace/services/helpers/date_helper.dart';
import 'package:iq_trace/services/user_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

import './components/user_details.dart';
import './components/iqt_drawer.dart';
import './components/not_verified.dart';
import './components/encoding.dart';
import './components/survey_prompt.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key, required this.title }) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _userService = UserService.instance;

  List<User>? activeUsers;

  @override
  Widget build(BuildContext context) {
    final _isVerified = _userService.currentUser.isVerified;

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
    final User user = _userService.currentUser;

    bool needSurvey = user.lastSurveyDate == null || 
      DateHelper.calculateDifference(user.lastSurveyDate!) < 0;
    
    if (user.isAdmin && activeUsers == null) {
      _userService.getUsersWithActiveSymptoms()
        .then((response) {
          print(response);
          if (response == null) {
            response = [];
          }
          setState(() => activeUsers = response);
        });
    }

    print("activeUsers");
    print(activeUsers);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (user.faceEncoding!.length == 0)
          Encoding(),
        if (needSurvey)
          SurveyPrompt(),
        if (activeUsers != null && activeUsers!.length > 0)
          AdminPrompt(),
        Center(
          child: QrImage(
            data: jsonEncode(user.debugToJson()),
            size: 280.0,
          ),
        ),
        UserDetails(user),
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
}

/* class HomeScreen extends StatelessWidget {
  HomeScreen({required this.title});

  final String title;

  final _userService = UserService.instance;

  @override
  Widget build(BuildContext context) {
    final _isVerified = _userService.currentUser.isVerified;

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
    final User user = _userService.currentUser;
    List<User>? activeUsers;

    bool needSurvey = user.lastSurveyDate == null || 
      DateHelper.calculateDifference(user.lastSurveyDate!) < 0;
    
    if (user.isAdmin) {
      _userService.getUsersWithActiveSymptoms()
        .then((response) {
          print(response);
          activeUsers = response;
        });
    }

    print("activeUsers");
    print(activeUsers);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (user.faceEncoding!.length == 0)
          Encoding(),
        if (needSurvey)
          SurveyPrompt(),
        if (activeUsers != null && activeUsers!.length > 0)
          AdminPrompt(),
        Center(
          child: QrImage(
            data: jsonEncode(user.debugToJson()),
            size: 280.0,
          ),
        ),
        UserDetails(user),
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
}
 */