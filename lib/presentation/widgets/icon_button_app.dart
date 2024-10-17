import 'package:flutter/material.dart';

class IconButtonApp extends StatelessWidget {
  const IconButtonApp(
      {super.key, required this.icon, this.color, this.onPressed, this.size});

  final IconData icon;
  final Color? color;
  final void Function()? onPressed;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      color: color,
      iconSize: size,
    );
  }
}
