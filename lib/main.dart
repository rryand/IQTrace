import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:iq_trace/constants.dart';
import 'package:iq_trace/services/auth_service.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/screens/admin/admin_screen.dart';
import 'package:iq_trace/screens/error/error_screen.dart';
import 'package:iq_trace/screens/home/home_screen.dart';
import 'package:iq_trace/screens/update/exposure_update_screen.dart';
import 'package:iq_trace/screens/update/quarantine_update_screen.dart';
import 'package:iq_trace/screens/login/login_screen.dart';
import 'package:iq_trace/screens/register/register_screen.dart';
import 'package:iq_trace/screens/register/camera_screen.dart';
import 'package:iq_trace/screens/register/display_image_screen.dart';
import 'package:iq_trace/screens/update/symptom_update_screen.dart';
import 'package:iq_trace/screens/scanner/qr_scanner_screen.dart';

List? cameras;

Future<void> main() async {
  print('starting app...');
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  await dotenv.load();

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse<User?>>(
      future: _auth.getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          switch (snapshot.data!.status) {
            case Status.COMPLETED:
              return IQTrace(user: snapshot.data!.data);
            case Status.ERROR:
              return IQTrace(
                errorMessage: snapshot.data!.message,
                onError: () => setState(() {}),
              ); // TODO: make better implementation, change to stream?
            case Status.LOADING:
              break;
          }
        } else {
          return Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        throw 'Unhandled null return';
      },
    );
  }
}

class IQTrace extends StatelessWidget {
  IQTrace({ this.user, this.errorMessage, this.onError });

  final User? user;
  final String? errorMessage;
  final Function? onError;

  @override
  Widget build(BuildContext context) {
    String initialRoute = user != null ? '/home' : '/login';

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: errorMessage == null ? _buildApp(context, initialRoute) 
        : _buildErrorPage(context, errorMessage!),
    );
  }

  Widget _buildApp(BuildContext context, String initialRoute) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: iqtPrimaryColor,
        secondaryHeaderColor: iqtSecondaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: iqtPrimaryColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: iqtPrimaryColor,
            primary: Colors.white,
          ),
        ),
      ),
      initialRoute: initialRoute,
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
        '/admin': (context) => AdminScreen(),
      },
    );
  }

  Widget _buildErrorPage(BuildContext context, String errorMessage) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: iqtPrimaryColor,
        secondaryHeaderColor: iqtSecondaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: iqtPrimaryColor,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('IQTrace'),
        ),
        body: ErrorScreen(
          errorMessage: errorMessage,
          onRetryPressed: () => onError!(),
        ),
      ),
    );
  }
}
