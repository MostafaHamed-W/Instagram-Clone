import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPass;

  const TextFieldInput({
    super.key,
    required this.inputController,
    required this.hintText,
    required this.keyboardType,
    this.isPass = false,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: inputController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
      ),
      keyboardType: keyboardType,
      obscureText: isPass,
    );
  }
}
