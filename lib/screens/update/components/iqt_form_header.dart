import 'package:flutter/material.dart';

class IQTFormHeader extends StatelessWidget {
  IQTFormHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline5?.apply(
            fontWeightDelta: 1,
            color: Colors.green[900],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4.0)),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.subtitle1?.apply(
            color: Colors.grey[600],
          ),
        ),
      ]
    );
  }
}
