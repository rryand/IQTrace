import 'package:flutter/material.dart';
import 'package:iq_trace/services/user_repository.dart';
import 'package:qr_flutter/qr_flutter.dart';

import './components/user_details.dart';
import './components/iqt_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final _userRepo = UserRepository.instance;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/iqt-icon-black-handle.png',
          height: 55,
        ),
        centerTitle: true,
        actions: [_buildQrScannerButton(context)],
        leading: _buildMenuButton(),
      ),
      drawer: IQTDrawer(_userRepo.currentUser),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,  
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: QrImage(
                data: _userRepo.currentUser.toJson().toString(),
                size: 225.0,
              ),
            ),
            UserDetails(_userRepo.currentUser),
          ],
        ),
      ),
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
