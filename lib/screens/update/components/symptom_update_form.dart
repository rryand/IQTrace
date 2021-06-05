import 'package:flutter/material.dart';

import 'checkbox_form_field.dart';
import 'iqt_form_column.dart';
import 'iqt_form_header.dart';

const SYMPTOMS = {
  'Cough': 'Ubo',
  'Fever': 'Lagnat',
  'Colds': 'Sipon',
  'Sore Throat': 'Masakit na lalamunan',
  'Loose Bowel Movements': 'Pagtatae',
  'Nausea/Vomiting': 'Nagduduwal or nagsusuka',
  'Shortness of Breath': 'Hingal sa paghihinga',
  'Sore Eyes': 'Pananakit o pamumula ng mata',
  'Chest Pain': 'Pananakit o paninikip ng dibdib',
  'Loss of smell and taste': 'Pagkawala ng pang-amoy at panlasa',
  'Body or muscle pain': 'Pananakit ng Katawan',
  'Headache': 'Sakit ng ulo'
};

class SymptomUpdateForm extends StatefulWidget {
  SymptomUpdateForm(this._formKey, this._symptoms);

  final GlobalKey<FormState> _formKey;
  final List _symptoms;

  @override
  _SymptomUpdateFormState createState() => _SymptomUpdateFormState();
}

class _SymptomUpdateFormState extends State<SymptomUpdateForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget._formKey,
        child: IQTFormColumn(
          children: <Widget>[
            IQTFormHeader(
              title: 'Do you have any of the following symptoms?',
              subtitle: 'May nararamdaman ka bang symptomas tulad ng mga ito?',
            ),
            ..._buildSymptomTiles(),
          ],
        ),
      ),
    );
  }

  _buildSymptomTiles() {
    final List<Widget> symptomWidgets = [];

    SYMPTOMS.forEach((String key, String value) {
      symptomWidgets.add(
        CheckboxFormField(
          title: key,
          subtitle: value,
          onSaved: (value) { 
            if (value == true) widget._symptoms.add(key.toLowerCase());
          },
        )
      );
    });
    symptomWidgets.add(
      Padding(padding: EdgeInsets.only(top: 24.0))
    );
    return symptomWidgets;
  }
}
