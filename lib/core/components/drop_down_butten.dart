import 'package:flutter/material.dart';
import 'package:merchant_app/core/components/text_form_field.dart';

// ignore: must_be_immutable
class DTDropdownButton extends StatefulWidget {

  @override
  State<DTDropdownButton> createState() => _DTDropdownButtonState();
}

class _DTDropdownButtonState extends State<DTDropdownButton> {
  String dropdownValue='cm';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon:const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Three', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
