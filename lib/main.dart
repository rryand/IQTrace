import 'package:flutter/material.dart';

import 'package:iq_trace/screens/home/home_screen.dart';
import 'package:iq_trace/constants.dart';
import './screens/update/symptom_update_screen.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(title: app_title),
        '/update': (context) => SymptomUpdateScreen(),
      },
    );
  }
}
