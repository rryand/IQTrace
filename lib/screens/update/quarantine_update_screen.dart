import 'package:flutter/material.dart';

import 'package:iq_trace/services/user_service.dart';
import './components/quarantine_update_form.dart';

class QuarantineUpdateScreen extends StatefulWidget {
  @override
  _QuarantineUpdateScreenState createState() => _QuarantineUpdateScreenState();
}

class _QuarantineUpdateScreenState extends State<QuarantineUpdateScreen> {
  bool _isQuarantined = false;
  bool _isLoading = false;

  void _setIsQuarantineState(bool value) {
    setState(() {
      _isQuarantined = value;
    });
  }

  Future<void> _saveSymptomUpdate(Map _arguments) async {
    final _userService = UserService();
    setState(() => _isLoading = true );

    _userService.updateUserSymptoms({ 'isQuarantined': _isQuarantined, ..._arguments });

    Navigator.pushNamedAndRemoveUntil(
        context, '/home', (Route<dynamic> route) => false);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Symptom update complete!')));

    setState(() => _isLoading = false );
  }

  @override
  Widget build(BuildContext context) {
    final _arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quarantine Update'),
      ),
      floatingActionButton: FloatingActionButton(
        child: _isLoading ? CircularProgressIndicator() : Icon(Icons.check),
        onPressed: () => _saveSymptomUpdate(_arguments),
      ),
      body: QuarantineUpdateForm(_setIsQuarantineState),
    );
  }
}