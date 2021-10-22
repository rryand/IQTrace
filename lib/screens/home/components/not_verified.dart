import 'package:flutter/material.dart';
import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/screens/error/error_screen.dart';
import 'package:iq_trace/services/auth_service.dart';
import 'package:iq_trace/services/user_service.dart';

class NotVerified extends StatefulWidget {
  const NotVerified({ Key? key }) : super(key: key);

  @override
  _NotVerifiedState createState() => _NotVerifiedState();
}

class _NotVerifiedState extends State<NotVerified> {
  final _authService = AuthService();
  final _userService = UserService.instance;

  bool _isLoading = false;

  Future<void> _signOut(BuildContext context) async {
    final _authService = AuthService();
    await _authService.signOut();

    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<void> _onPressed() async {
    print("Verify");
    User user = _userService.currentUser;

    setState(() => _isLoading = true);

    ApiResponse response = await _authService.sendVerificationEmail(user.email!);

    switch (response.status) {
      case Status.COMPLETED:
        await _signOut(context);
        break;
      case Status.ERROR:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => 
              ErrorScreen(
                errorMessage: response.message!,
                onRetryPressed: () => Navigator.pop(context)
              ),
          ),
        );
        break;
      default:
        break;
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Email is not verified",
            style: TextStyle(
              fontSize: 28,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(padding: EdgeInsets.all(8.0)),
          Text(
            "Click on the button below to verify your email."
          ),
          Padding(padding: EdgeInsets.all(4.0)),
          TextButton(
            onPressed: _onPressed,
            child: _isLoading ? 
              CircularProgressIndicator() : 
              Text("Verify"),
          ),
        ],
      ),
    );
  }
}
