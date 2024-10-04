import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AnimateWidget extends StatelessWidget {
  const AnimateWidget({
    super.key,
    this.duration = const Duration(milliseconds: 800),
    required this.child,
  });

  final Duration duration;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1700),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: const Color.fromRGBO(196, 135, 198, .3)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(196, 135, 198, .3),
                blurRadius: 20,
                offset: Offset(0, 10),
              )
            ]),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromRGBO(196, 135, 198, .3)))),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.grey.shade700)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey.shade700)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
