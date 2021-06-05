import 'package:flutter/material.dart';

import './components/exposure_update_form.dart';

class ExposureUpdateScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _exposure = [];

  @override
  Widget build(BuildContext context) {
    final _arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exposure Update'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          _exposure.clear();
          _formKey.currentState?.save();
          Navigator.pushNamed(
            context,
            '/update/quarantine',
            arguments: { 'exposure': _exposure, ..._arguments}
          );
        },
      ),
      body: ExposureUpdateForm(_formKey, _exposure),
    );
  }
}
