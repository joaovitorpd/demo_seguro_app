import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldRoudBorder extends StatelessWidget {
  const TextFieldRoudBorder({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.inputFormatter1,
    this.inputFormatter2,
    this.autofocus,
    this.obscureText,
    this.onSubmitted,
    this.textInputAction,
  });

  final bool? autofocus;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? labelText;
  final TextInputFormatter? inputFormatter1;
  final TextInputFormatter? inputFormatter2;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
      controller: controller,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      autofocus: autofocus ?? false,
      inputFormatters: [?inputFormatter1, ?inputFormatter2],
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        label: Center(child: Text(labelText ?? "")),
        labelStyle: TextStyle(
          fontSize: 20.0,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 3.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 3.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
