import 'package:flutter/material.dart';

class ErrorScreenArguments {
  final String errorMessage;
  final Function onRetryPressed;

  ErrorScreenArguments(this.errorMessage, this.onRetryPressed);
}

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  final Function onRetryPressed;

  const ErrorScreen({ 
    Key? key, 
    required this.errorMessage, 
    required this.onRetryPressed }) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Error screen build');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightGreen,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              child: Text('Retry', style: TextStyle(color: Colors.white)),
              onPressed: () => onRetryPressed(),
            )
          ],
        ),
      ),
    );
  }
}
