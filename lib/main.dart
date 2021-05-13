import 'package:flutter/material.dart';

import 'package:iq_trace/screens/home/home_screen.dart';
import 'package:iq_trace/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: iqtPrimaryColor,
      ),
      home: HomeScreen(title: app_title),
    );
  }
}
