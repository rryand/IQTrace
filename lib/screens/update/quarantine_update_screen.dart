import 'package:flutter/material.dart';
import 'package:iq_trace/networking/api_response.dart';
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

  // TODO: update user symptom
  Future<void> _saveSymptomUpdate(Map _arguments) async {
    final _userService = UserService();
    setState(() => _isLoading = true );

    final response = await _userService.updateUserSymptoms(
      { 'isQuarantined': _isQuarantined, ..._arguments }
    );

    Navigator.pushNamedAndRemoveUntil(
        context, '/home', (Route<dynamic> route) => false);
    
    switch (response.status) {
      case Status.COMPLETED:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Symptom update complete!')));
        break;
      case Status.ERROR:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.message!)));
        break;
      default:
        break;
    }

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
      floatingActionButton: _isLoading ? 
        CircularProgressIndicator() : 
        FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () => _saveSymptomUpdate(_arguments),
        ),
      body: QuarantineUpdateForm(_setIsQuarantineState),
    );
  }
}
