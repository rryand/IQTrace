import 'package:flutter/material.dart';

import 'package:iq_trace/constants.dart';

class UserDetails extends StatelessWidget {
  UserDetails(this.user);

  final user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          user.name,
          style: Theme.of(context).textTheme.headline4?.copyWith(
            color: iqtPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        Text(
          user.email,
          style: Theme.of(context).textTheme.headline6?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        Text(
          user.contactNumber,
          style: Theme.of(context).textTheme.headline6?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
