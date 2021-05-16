import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:iq_trace/screens/home/home_screen.dart';
import 'package:iq_trace/constants.dart';
import './screens/update/symptom_update_screen.dart';
import './screens/scanner/qr_scanner_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Oops, something went wrong!'),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return IQTrace();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class IQTrace extends StatelessWidget {
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
        '/scanner': (context) => QRScannerScreen(),
      },
    );
  }
}
