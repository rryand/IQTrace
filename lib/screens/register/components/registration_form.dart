import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:iq_trace/services/user_service.dart';
import 'registration_form_button.dart';
import '../../../models/user.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm(this.cameras);

  final cameras;

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _userService = UserService();
  final _authInstance = FirebaseAuth.instance; // TODO: DELETE
  final _dateFieldCtrl = TextEditingController();
  final _passwordFieldCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _user = IQTUser();
  DateTime _selectedDate = DateTime(1996, 9, 16);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? _newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1910, 1),
      lastDate: DateTime.now(),
    );

    if (_newSelectedDate != null) {
      _selectedDate = _newSelectedDate;
      _dateFieldCtrl.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Register',
            style: Theme.of(context).textTheme.headline3?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'something@email.com',
              labelText: 'Email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              } else if (!value.contains(RegExp(r'^\w+@\w+\.\w+$'))) {
                return 'please enter a valid email address';
              }
              return null;
            },
            onSaved: (value) => _user.email = value!,
          ),
          TextFormField(
            controller: _passwordFieldCtrl,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'password',
              labelText: 'Password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              } else if (value.length < 3) {
                return 'password is too short';
              } else if (value.contains(RegExp(r'\s'))) {
                return 'please enter a valid password';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Juan',
              labelText: 'Given Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }
              return null;
            },
            onSaved: (value) => _user.firstName = value!,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Dela Cruz',
              labelText: 'Surname',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }
              return null;
            },
            onSaved: (value) => _user.lastName = value!,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: '09*********',
              labelText: 'Contact Number',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              } else if (!value.contains(RegExp(r'^09\d{9}'))) {
                return 'please enter a valid phone number';
              }
              return null;
            },
            onSaved: (value) => _user.contactNumber = value!,
          ),
          TextFormField(
            focusNode: AlwaysDisabledFocusNode(),
            controller: _dateFieldCtrl,
            decoration: InputDecoration(
              hintText: 'YYYY-MM-DD',
              labelText: 'Date of Birth',
            ),
            onTap: () => _selectDate(context),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }
              return null;
            },
            onSaved: (value) => _user.birthday = value!,
          ),
          Padding(padding: EdgeInsetsDirectional.only(top: 24.0)),
          RegistrationFormButton(
            text: 'Next',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pushNamed(
                  context,
                  '/register/camera',
                  arguments: {
                    'formKey': _formKey,
                    'user': _user,
                    'password': _passwordFieldCtrl.text,
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
