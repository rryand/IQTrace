import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/services/auth_service.dart';

import 'registration_form_button.dart';
import '../../../models/user.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm(this.cameras);

  final cameras;

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final dateFieldCtrl = TextEditingController();
  final passwordFieldCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final user = User();
  final address = {};
  bool _isLoading = false;
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
      dateFieldCtrl.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
    }
  }

  void _onPressed() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() => _isLoading = true);

      user.address = address['street'] + ', ' + address['brgy'] + ', ' 
        + address['city'] + ', ' + address['province'];
      
      AuthService()
        .register(user, passwordFieldCtrl.text)
        .then((ApiResponse<void> response) {
          print("Register call complete");
          switch (response.status) {
            case Status.COMPLETED:
              Navigator.pushNamed(
                context,
                '/register/camera',
                arguments: {
                  'formKey': formKey,
                  'user': user,
                },
              );
              break;
            case Status.ERROR:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('ERROR: ${response.message}'))
              );
              break;
            default:
              break;
          }
        });
      
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
              } else if (!value.contains(RegExp(r'^.+@.+\..+$'))) {
                return 'please enter a valid email address';
              }
              return null;
            },
            onSaved: (value) => user.email = value!,
          ),
          TextFormField(
            controller: passwordFieldCtrl,
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
            onSaved: (value) => user.firstName = value!,
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
            onSaved: (value) => user.lastName = value!,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: '001 Main Street',
              labelText: 'House no./Street Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }
              return null;
            },
            onSaved: (value) => address['street'] = value!,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Brgy. XXXX',
              labelText: 'Barangay',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }
              return null;
            },
            onSaved: (value) => address['brgy'] = value!,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'XXXX City',
              labelText: 'Town/City',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }
              return null;
            },
            onSaved: (value) => address['city'] = value!,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'NCR',
              labelText: 'Province',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }
              return null;
            },
            onSaved: (value) => address['province'] = value!,
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
            onSaved: (value) => user.contactNumber = value!,
          ),
          TextFormField(
            focusNode: AlwaysDisabledFocusNode(),
            controller: dateFieldCtrl,
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
            onSaved: (value) => user.birthday = value!,
          ),
          Padding(padding: EdgeInsetsDirectional.only(top: 24.0)),
          _isLoading ? CircularProgressIndicator() : RegistrationFormButton(
            text: 'Next',
            onPressed: _onPressed,
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
