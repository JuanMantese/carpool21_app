import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {

  Function(String text) onChanged;
  String? Function(String?)? validator;
  String text;
  TextInputType inputType;
  IconData icon;
  EdgeInsetsGeometry padding;

  CustomTextField({
    super.key, 
    required this.onChanged,
    this.validator,
    required this.text,
    required this.inputType,
    this.icon = Icons.visibility,
    this.padding = const EdgeInsets.only(top: 30, bottom: 30, right: 15, left: 15),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: (text) {
          onChanged(text);
        },
        validator: validator,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(color: Color(0xFF006D59)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder( 
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color(0xFF006D59)),
          ),
        ),
        keyboardType: inputType,
      ),
    );
  }
}