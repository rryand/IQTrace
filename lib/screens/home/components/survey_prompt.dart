import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SurveyPrompt extends StatelessWidget {
  const SurveyPrompt({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.red.shade200,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              "Please fill up the symptom survey.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: EdgeInsets.all(2.0)),
            Text(
              "Click on the button below to do so."
            ),
            Padding(padding: EdgeInsets.all(2.0)),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(
                '/update',
              ),
              child: Text('Survey'),
            ),
          ],
        ),
      ),
    );
  }
}
