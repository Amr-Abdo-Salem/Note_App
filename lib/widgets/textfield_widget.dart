import 'package:flutter/material.dart';

import '../controller/constans.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.maxLines,
    required this.onSaved,
    this.onChange,
    // required this.onValidate,
  });
  final String hintText;
  final int maxLines;
  final Function(String?)? onSaved;
  final Function(String)? onChange;
  // final FormFieldValidator onValidate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      onChanged: onChange,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return " Please Enter Value !";
        } else {
          return null;
        }
      },
      cursorColor: kPrimaryColor,
      cursorHeight: 20,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1.5,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: kPrimaryColor,
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
