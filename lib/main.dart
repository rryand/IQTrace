import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:iq_trace/screens/home/home_screen.dart';
import 'package:iq_trace/constants.dart';
import 'package:iq_trace/screens/update/exposure_update_screen.dart';
import 'package:iq_trace/screens/update/quarantine_update_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/register/register_screen.dart';
import 'screens/register/camera_screen.dart';
import 'screens/register/display_image_screen.dart';
import 'screens/update/symptom_update_screen.dart';
import 'screens/scanner/qr_scanner_screen.dart';

List? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: iqtPrimaryColor,
          secondaryHeaderColor: iqtSecondaryColor,
        ),
        initialRoute: '/login',
        routes: {
          '/home': (context) => HomeScreen(title: app_title),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(cameras),
          '/register/camera': (context) => CameraScreen(cameras),
          '/register/camera/image': (context) => DisplayImageScreen(),
          '/update': (context) => SymptomUpdateScreen(),
          '/update/exposure': (context) => ExposureUpdateScreen(),
          '/update/quarantine': (context) => QuarantineUpdateScreen(),
          '/scanner': (context) => QRScannerScreen(),
        },
      ),
    );
  }
}
