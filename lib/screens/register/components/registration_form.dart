import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm(this.formKey);

  final formKey;

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _dateFieldCtrl = TextEditingController();
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
      key: widget.formKey,
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
          ),
          TextFormField(
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
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: '09*********',
              labelText: 'Contact Number',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              } else if (!value.contains(RegExp(r'^09\D{9}'))) {
                return 'please enter a valid phone number';
              }
              return null;
            },
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
          ),
          Padding(padding: EdgeInsetsDirectional.only(top: 24.0)),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (widget.formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Register'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty
                  .resolveWith((states) => Theme.of(context).primaryColor,
                ),
              ),
            ),
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
