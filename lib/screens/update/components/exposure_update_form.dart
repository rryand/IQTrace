import 'package:flutter/material.dart';

import 'checkbox_form_field.dart';
import 'package:iq_trace/screens/common/iqt_column.dart';
import 'package:iq_trace/screens/common/iqt_header.dart';

class ExposureUpdateForm extends StatelessWidget {
  ExposureUpdateForm(this._formKey, this._exposure);

  final _formKey;
  final _exposure;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: IQTColumn(
          children: <Widget>[
            IQTHeader(
              title: 'Have you been exposed to any of the following?',
              subtitle: 'Meron ka bang nakasalamuha sa mga sumusunod?',
            ),
            CheckboxFormField(
              title: 'Healthcare worker',
              subtitle: 'Trabahador sa mga ospital',
              onSaved: (value) {
                if (value == true) _exposure.add('healthcare');
              },
            ),
            CheckboxFormField(
              title: 'Baranggay enforcer',
              subtitle: 'Mga taga-baranggay',
              onSaved: (value) {
                if (value == true) _exposure.add('baranggay');
              },
            ),
            CheckboxFormField(
              title: 'Policeman or soldier',
              subtitle: 'Pulis o sundalo',
              onSaved: (value) {
                if (value == true) _exposure.add('police/soldier');
              },
            ),
            CheckboxFormField(
              title: 'Confirmed or Probable COVID',
              subtitle: 'Kumpirmado o inoobserbahang may COVID',
              onSaved: (value) {
                if (value == true) _exposure.add('confirmed covid');
              },
            ),
            Padding(padding: EdgeInsets.only(top: 24.0)),
          ],
        ),
      ),
    );
  }
}
