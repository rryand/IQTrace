import 'package:flutter/material.dart';
import 'package:iq_trace/constants.dart';

class IQTHeader extends StatelessWidget {
  IQTHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            color: iqtPrimaryColor,
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4.0)),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      ]
    );
  }
}
