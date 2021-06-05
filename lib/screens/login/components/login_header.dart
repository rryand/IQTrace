import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  LoginHeader({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: width,
          height: height * 0.2,
          margin: EdgeInsetsDirectional.only(end: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(100))
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/iqt-icon-black-handle.png',
              width: 80,
            ),
            Text(
              'IQTrace',
              style: Theme.of(context).textTheme.headline2?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
