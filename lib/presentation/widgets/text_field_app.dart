import 'package:flutter/material.dart';

class TextFieldApp extends StatelessWidget {
  const TextFieldApp(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onChanged,
      this.obscureText,
      required this.icon,
      this.validator,
      this.enabled = true,
      this.keyboardType,
      this.onPressed,
      this.border, this.color});

  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final bool? obscureText;
  final Widget icon;
  final FormFieldValidator? validator;
  final bool enabled;
  final TextInputType? keyboardType;
  final void Function()? onPressed;
  final InputBorder? border;
final Color? color;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
      
        hintText: hintText,
        hintStyle: TextStyle(color: color),
        suffixIcon: IconButton(icon: icon, onPressed: onPressed),
        border: border,
      ),
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      validator: validator,
      enabled: enabled,
      keyboardType: keyboardType,
    );
  }
}
