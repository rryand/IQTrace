import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/constants.dart';
import './components/iqt_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({required this.title});

  final String title;

  final User user = User(
    'Ramses Ryan',
    'Dineros',
    9,
    16,
    1996,
    '09294137458',
    'ramsesryandinerosramsesryandineros@gmail.com',
    'http://FAKEURL.com',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/iqt-icon-black-handle.png',
          height: 55,
        ),
        centerTitle: true,
        actions: [
          _buildQrScannerButton(),
        ],
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

  Widget _buildQrScannerButton() {
    return IconButton(
      icon: Icon(
        Icons.qr_code_scanner,
        size: 30
      ),
      onPressed: () {}
    );
  }
}

class UserDetails extends StatelessWidget {
  UserDetails(this.user);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          user.name,
          style: Theme.of(context).textTheme.headline4?.copyWith(
            color: iqtPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        Text(
          user.email,
          style: Theme.of(context).textTheme.headline6?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        Text(
          user.contactNumber,
          style: Theme.of(context).textTheme.headline6?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
