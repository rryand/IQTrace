import 'package:flutter/material.dart';
import 'package:iq_trace/services/user_service.dart';

class Encoding extends StatelessWidget {
  const Encoding({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userService = UserService.instance;

    return ColoredBox(
      color: Colors.red.shade200,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              "You have not uploaded your picture for encoding!"
              " Click on the button below to do so."
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(
                '/register/camera',
                arguments: {
                  'isLoggedIn': true,
                  'user': _userService.currentUser,
                },
              ),
              child: Text('Camera')
            ),
          ],
        ),
      ),
    );
  }
}