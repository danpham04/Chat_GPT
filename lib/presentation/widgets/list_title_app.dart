import 'package:flutter/material.dart';

class ListTitleApp extends StatelessWidget {
  const ListTitleApp(
      {super.key,
      this.onTap,
      this.sizeText,
      this.fontWeight,
      this.colorText,
      required this.radius,
      this.widgetLeading,
      this.widgetTrailing,
      required this.textTitle,
      this.paddingTitle,
      this.colorOne,
      this.colorTwo});

  final void Function()? onTap;

  final String textTitle;
  final double? sizeText;
  final double? paddingTitle;
  final FontWeight? fontWeight;
  final Color? colorOne;
  final Color? colorTwo;
  final Color? colorText;
  final double radius;
  final Widget? widgetLeading;
  final Widget? widgetTrailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingTitle ?? 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          gradient: LinearGradient(colors: [
            colorOne ?? const Color.fromARGB(255, 210, 201, 204),
            colorTwo ?? Colors.lightBlue
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: ListTile(
          leading: widgetLeading,
          trailing: widgetTrailing,
          title: Text(
            textTitle,
            style: TextStyle(
                fontSize: sizeText, fontWeight: fontWeight, color: colorText),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
