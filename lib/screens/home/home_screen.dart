import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:iq_trace/services/user_service.dart';
import 'package:iq_trace/models/user.dart';
import './components/user_details.dart';
import './components/iqt_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<IQTUser>(
      future: UserService().getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong.');
        } else if (snapshot.connectionState == ConnectionState.done) {
          IQTUser _user = snapshot.data!;
          return _buildScaffold(context, _user);
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }

  Widget _buildScaffold(context, user) {
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: QrImage(
                data: user.toJson().toString(),
                size: 225.0,
              ),
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
