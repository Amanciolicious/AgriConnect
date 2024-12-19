import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // Sample order history
  final List<Map<String, dynamic>> orderHistory = [
    {
      "orderId": 1,
      "products": [
        {
          "imageUrl": "assets/images/product1.jpg", // Image URL for the product
          "productName": "Fresh Apples",
          "quantity": 2,
          "price": 5.0
        },
        {
          "imageUrl": "assets/images/product2.jpg", // Image URL for another product
          "productName": "Organic Carrots",
          "quantity": 1,
          "price": 3.0
        }
      ],
      "orderStatus": "Delivered",
      "orderDate": "2024-11-15"
    },
    {
      "orderId": 2,
      "products": [
        {
          "imageUrl": "assets/images/product3.jpg", // Image URL for the product
          "productName": "Tomatoes",
          "quantity": 3,
          "price": 4.0
        }
      ],
      "orderStatus": "Processing",
      "orderDate": "2024-12-01"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(IconlyBroken.edit),
            onPressed: () {
              // Add functionality for editing profile
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info Section
            const Text(
              "User Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Name: Amancio"),
            const Text("Email: amancio@example.com"),
            const SizedBox(height: 20),

            // Order History Section
            const Text(
              "Order History",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  var order = orderHistory[index];
                  return OrderCard(order: order);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header with Order Date and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID: ${order['orderId']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  order['orderStatus'],
                  style: TextStyle(
                    color: order['orderStatus'] == "Delivered"
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text("Order Date: ${order['orderDate']}"),
            const SizedBox(height: 12),

            // Display Product Details
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order['products'].length,
              itemBuilder: (context, productIndex) {
                var product = order['products'][productIndex];
                return ProductRow(product: product);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductRow extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductRow({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Product Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            product['imageUrl'],
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        // Product Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product['productName'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Quantity: ${product['quantity']}"),
            Text("Price: \$${product['price']}"),
          ],
        ),
      ],
    );
  }
}
