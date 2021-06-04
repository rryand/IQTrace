import 'package:flutter/material.dart';

import 'iqt_form_column.dart';
import 'iqt_form_header.dart';

class QuarantineUpdateForm extends StatelessWidget {
  QuarantineUpdateForm(this._setIsQuarantineState);

  final _setIsQuarantineState;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: IQTFormColumn(
        children: <Widget>[
          IQTFormHeader(
            title: 'Have you ever been asked to be isolated or '
              'quarantined by a medical professional or a local official?',
            subtitle: 'Ikaw ba ay na sabihan ng mahiwalay at dumistansya '
              'sa iyong mga kasama sa bahay ayon sa isang doctor or taga health center?',
          ),
          DropdownButtonFormField(
            value: false,
            items: [
              DropdownMenuItem(child: Text('Yes'), value: true),
              DropdownMenuItem(child: Text('No'), value: false),
            ],
            onChanged: (bool? value) => _setIsQuarantineState(value!),
          ),
        ]
      ),
    );
  }
}