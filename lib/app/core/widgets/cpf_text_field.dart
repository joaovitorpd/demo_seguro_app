import 'package:demo_seguro_app/app/core/widgets/text_field_roud_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CpfTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final bool? autofocus;

  const CpfTextField({
    required this.controller,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.label = 'CPF',
    this.autofocus,
    super.key,
  });

  static final _formatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'\d')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return TextFieldRoudBorder(
      controller: controller,
      autofocus: autofocus,
      labelText: label,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatter1: FilteringTextInputFormatter.digitsOnly,
      inputFormatter2: _formatter,
    );
  }

  String get rawCpf => controller.text.replaceAll(RegExp(r'[^0-9]'), '');
}
