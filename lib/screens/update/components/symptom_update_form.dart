import 'package:flutter/material.dart';

import './checkbox_form_field.dart';
import './iqt_form_column.dart';

const _symptoms = {
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
  @override
  _SymptomUpdateFormState createState() => _SymptomUpdateFormState();
}

class _SymptomUpdateFormState extends State<SymptomUpdateForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: IQTFormColumn(
          children: <Widget>[
            IQTFormHeader(
              title: 'Do you have any of the following symptoms?',
              subtitle: 'May nararamdaman ka bang symptomas tulad ng mga ito?',
            ),
            ..._buildSymptomTiles(),
            IQTFormHeader(
              title: 'Have you been exposed to any of the following?',
              subtitle: 'Meron ka bang nakasalamuha sa mga sumusunod?',
            ),
            CheckboxFormField(
              title: 'Healthcare worker',
              subtitle: 'Trabahador sa mga ospital',
              onSaved: (value) {},
            ),
            CheckboxFormField(
              title: 'Baranggay enforcer',
              subtitle: 'Mga taga-baranggay',
              onSaved: (value) {},
            ),
            CheckboxFormField(
              title: 'Policeman or soldier',
              subtitle: 'Pulis o sundalo',
              onSaved: (value) {},
            ),
            CheckboxFormField(
              title: 'Confirmed or Probable COVID',
              subtitle: 'Kumpirmado o inoobserbahang may COVID',
              onSaved: (value) {},
            ),
            Padding(padding: EdgeInsets.only(top: 24.0)),
            IQTFormHeader(
              title: 'Have you ever been asked to be isolated or '
                'quarantined by a medical professional or a local official?',
              subtitle: 'Ikaw ba ay na sabihan ng mahiwalay at dumistansya '
                'sa iyong mga kasama sa bahay ayon sa isang doctor or taga health center?',
            ),
          ],
        ),
      ),
    );
  }

  _buildSymptomTiles() {
    final List<Widget> symptomWidgets = [];

    _symptoms.forEach((key, value) {
      symptomWidgets.add(
        CheckboxFormField(
          title: key,
          subtitle: value,
          onSaved: (value) {},
        )
      );
    });
    symptomWidgets.add(
      Padding(padding: EdgeInsets.only(top: 24.0))
    );
    return symptomWidgets;
  }
}

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
