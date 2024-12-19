import 'package:flutter/material.dart';

class ViewListingsPage extends StatelessWidget {
  const ViewListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Listings")),
      body: const Center(child: Text("Listings will be displayed here.")),
    );
  }
}