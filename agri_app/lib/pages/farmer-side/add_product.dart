// add_product_page.dart
import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List a Product"),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const TextField(
              decoration:  InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
           const  TextField(
              decoration:  InputDecoration(
                labelText: "Quantity (e.g., 20 kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
    const TextField(
              decoration:  InputDecoration(
                labelText: "Price (e.g., \$30)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to save the product details
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Product listed successfully!")),
                );
                Navigator.pop(context); // Return to the previous page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}