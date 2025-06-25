import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CpfTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool autofocus;

  const CpfTextField({
    required this.controller,
    this.label = 'CPF',
    this.autofocus = false,
    super.key,
  });

  static final _formatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly, _formatter],
      decoration: InputDecoration(labelText: label),
    );
  }

  String get rawCpf => controller.text.replaceAll(RegExp(r'[^0-9]'), '');
}
