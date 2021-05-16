import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:iq_trace/models/user.dart';
import './components/user_details.dart';
import './components/iqt_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({required this.title});

  final String title;
  final IQTUser user = IQTUser(
    'Ramses Ryan',
    'Dineros',
    9,
    16,
    1996,
    '09294137458',
    'ramsesryandinerosramsesryandineros@gmail.com',
    'http://FAKEURL.com',
    true,
  );

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print(auth.currentUser);
    
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
      drawer: IQTDrawer(user),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,  
        ),
        child:  Column(
          children: [
            QrImage(
              data: user.toJson().toString(),
              size: 225.0,
            ),
            UserDetails(user),
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
