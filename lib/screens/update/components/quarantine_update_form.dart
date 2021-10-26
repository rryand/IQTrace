import 'package:flutter/material.dart';

import 'package:iq_trace/screens/common/iqt_column.dart';
import 'package:iq_trace/screens/common/iqt_header.dart';

class QuarantineUpdateForm extends StatelessWidget {
  QuarantineUpdateForm(this._setIsQuarantineState);

  final _setIsQuarantineState;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: IQTColumn(
        children: <Widget>[
          IQTHeader(
            title: 'Have you ever been asked to be isolated or '
              'quarantined by a medical professional or a local official?',
            subtitle: 'Ikaw ba ay na sabihan ng mahiwalay at dumistansya '
              'sa iyong mga kasama sa bahay ayon sa isang doctor or taga '
              'health center?',
          ),
          DropdownButtonFormField(
            value: false,
            items: [
              DropdownMenuItem(child: Text('Yes'), value: true),
              DropdownMenuItem(child: Text('No'), value: false),
            ],
            onChanged: (bool? value) => _setIsQuarantineState(value!),
          ),
          Padding(padding: EdgeInsets.all(16.0)),
          Text(
            "I am aware that I am releasing pertinent medical information for "
            "the purpose of prioritization of the COVID 19 RT-PCR as a "
            "prerequisite for my work."
          ),
          Padding(padding: EdgeInsets.all(4.0)),
          Text(
            "I declare that all answers/information I have provided on this "
            "questionnaire is true and accurate to the best of my knowledge."
          ),
        ]
      ),
    );
  }
}
