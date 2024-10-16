import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber[200],
        title: const Text("Xin chào bạn"),
      ),
      body: const Center(
        child: Text("HAiiiiiiii"),
      ),
    );
  }
}
