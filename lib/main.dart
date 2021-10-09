import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/screens/home/home_screen.dart';
import 'package:iq_trace/constants.dart';
import 'package:iq_trace/screens/update/exposure_update_screen.dart';
import 'package:iq_trace/screens/update/quarantine_update_screen.dart';
import 'package:iq_trace/services/auth_service.dart';
import 'screens/login/login_screen.dart';
import 'screens/register/register_screen.dart';
import 'screens/register/camera_screen.dart';
import 'screens/register/display_image_screen.dart';
import 'screens/update/symptom_update_screen.dart';
import 'screens/scanner/qr_scanner_screen.dart';
import 'models/user.dart';

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
  final _isError = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse<User?>>(
      future: _auth.getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          switch (snapshot.data!.status) {
            case Status.COMPLETED:
              return IQTrace(snapshot.data!.data);
            case Status.ERROR:
              return Directionality(
                textDirection: TextDirection.ltr,
                child: Center(
                  child: Text(snapshot.data!.message!),
                ),
              ); // TODO: make better implementation, change to stream?
              /* return ErrorScreen(
                errorMessage: snapshot.data!.message!,
                onRetryPressed: () => 
                  Navigator
                    .of(context)
                    .pop(),
              ); */
            case Status.LOADING:
              break;
          }
        } else {
          return CircularProgressIndicator();
        }
        throw 'Unhandled null return';
      },
    );
  }
}

class IQTrace extends StatelessWidget {
  IQTrace(this.user);

  final User? user;

  @override
  Widget build(BuildContext context) {
    String initialRoute = user != null ? '/home' : '/login';

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: iqtPrimaryColor,
          secondaryHeaderColor: iqtSecondaryColor,
          appBarTheme: AppBarTheme(
            backgroundColor: iqtPrimaryColor,
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
        },
      ),
    );
  }
}
