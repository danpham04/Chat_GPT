import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomFedeinImg extends StatelessWidget {
  const CustomFedeinImg({
    super.key,
    required this.pathImg,
    this.fit,
    this.duration = const Duration(milliseconds: 800),
    required this.height,
    required this.width, this.top,
  });

  final String pathImg;
  final BoxFit? fit;
  final Duration duration;
  final double height;
  final double width;
  final double? top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      height: height,
      width: width,
      child: FadeInUp(
        duration: duration,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(pathImg), fit: fit),
          ),
        ),
      ),
    );
  }
}
