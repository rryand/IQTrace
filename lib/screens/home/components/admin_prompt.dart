import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPrompt extends StatelessWidget {
  const AdminPrompt({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.red.shade200,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              "User with active symptoms has been detected.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: EdgeInsets.all(2.0)),
            Text(
              "Click on the button below to view."
            ),
            Padding(padding: EdgeInsets.all(2.0)),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(
                '/admin',
              ),
              child: Text('Admin'),
            ),
          ],
        ),
      ),
    );
  }
}
