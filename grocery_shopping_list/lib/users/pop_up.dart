import 'package:flutter/material.dart';

class MyCheckboxPopup extends StatefulWidget {
  @override
  _MyCheckboxPopupState createState() => _MyCheckboxPopupState();
}

class _MyCheckboxPopupState extends State<MyCheckboxPopup> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Checkbox Popup'),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return CheckboxListTile(
                    title: Text('Checkbox'),
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  );
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
      child: Text('Open Popup'),
    );
  }
}