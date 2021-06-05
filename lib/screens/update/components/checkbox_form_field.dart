import 'package:flutter/material.dart';

import 'package:iq_trace/constants.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
    {
      required String title,
      required String subtitle,
      required FormFieldSetter<bool> onSaved,
      bool initialValue = false,
    }
  ) : super(
    onSaved: onSaved,
    initialValue: initialValue,
    builder: (FormFieldState<bool> state) {
      return Container(
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: Colors.green[50],
          border: Border.all(color: iqtPrimaryColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: CheckboxListTile(
          activeColor: iqtPrimaryColor,
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
          value: state.value,
          onChanged: state.didChange,
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );
    },
  );
}

