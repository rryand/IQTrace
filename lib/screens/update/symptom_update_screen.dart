import 'package:flutter/material.dart';

import './components/symptom_update_form.dart';

class SymptomUpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Update'),
      ),
      body: SymptomUpdateForm(),
    );
  }
}
