import 'package:flutter/material.dart';

class CheckOrdersPage extends StatelessWidget {
  const CheckOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Check Orders")),
      body: const Center(child: Text("Orders will be displayed here.")),
    );
  }
}