import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomFadeText extends StatelessWidget {
  const CustomFadeText({
    super.key,
    required this.text,
    this.color,
    this.duration = const Duration(milliseconds: 800),
    this.fontWeight,
    this.size,
    this.onPressed,
  });

  final String text;
  final Color? color;
  final Duration duration;
  final FontWeight? fontWeight;
  final double? size;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: duration,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style:
              TextStyle(color: color, fontWeight: fontWeight, fontSize: size),
        ),
      ),
    );
  }
}
