import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Services'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Delivery Service
          ServiceCard(
            icon: IconlyBold.bag,
            title: "Fast Delivery",
            description:
                "Get your produce delivered to your doorsteps with quick and reliable delivery services.",
            onPressed: () {
              // Navigate to delivery service request or details page
            },
          ),
          const SizedBox(height: 16),
          
          // Customer Support Service
          ServiceCard(
            icon: IconlyBold.heart,
            title: "Customer Support",
            description:
                "Need help? Our customer support team is here to assist you with any issues.",
            onPressed: () {
              // Navigate to support page or chat feature
            },
          ),
          const SizedBox(height: 16),
          
          // Payment Methods Service
          ServiceCard(
            icon: IconlyBold.wallet,
            title: "Payment Options",
            description:
                "Choose from a variety of secure payment methods to complete your purchase.",
            onPressed: () {
              // Navigate to payment options setup
            },
          ),
          const SizedBox(height: 16),
          
          // Return/Refund Service
          ServiceCard(
            icon: IconlyBold.arrowDownCircle,
            title: "Return & Refund",
            description:
                "Easily return items or request a refund if you're not satisfied with your order.",
            onPressed: () {
              // Navigate to return/refund process page
            },
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onPressed;

  const ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 40,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
