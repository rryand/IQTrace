import 'package:flutter/material.dart';

import './components/symptom_update_form.dart';

class SymptomUpdateScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _symptoms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Update'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          _symptoms.clear();
          _formKey.currentState?.save();
          Navigator.pushNamed(
            context,
            '/update/exposure',
            arguments: { 'symptoms': _symptoms }
          );
        },
      ),
      body: SymptomUpdateForm(_formKey, _symptoms),
    );
  }
}
