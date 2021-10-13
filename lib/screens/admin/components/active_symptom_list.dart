import 'package:flutter/material.dart';
import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/screens/common/iqt_column.dart';
import 'package:iq_trace/screens/common/iqt_header.dart';

class ActiveSymptomList extends StatelessWidget {
  const ActiveSymptomList({ Key? key, required this.usersWithSymptoms}) 
  : super(key: key);

  final List<User>? usersWithSymptoms;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IQTColumn(
        children: <Widget>[
          IQTHeader(
            title: 'Symptom Notifications',
            subtitle: 'List of users with active symptoms:',
          ),
          ...?_buildUsersWithSymptomsList(),
          _buildCount()
        ],
      ),
    );
  }

  List<Widget>? _buildUsersWithSymptomsList() {
    if (usersWithSymptoms == null) return null;

    final widgets = <Widget>[Padding(padding: EdgeInsets.only(top: 10))];
    usersWithSymptoms!.forEach((user) {
      widgets.add(Text('User: ${user.name} | survey: ${user.survey}'));
      widgets.add(Divider());
    });

    return widgets;
  }

  Widget _buildCount() {
    final count = usersWithSymptoms?.length ?? 0;
    print(usersWithSymptoms);
    return Text(
      'Count: $count'
    );
  }
}