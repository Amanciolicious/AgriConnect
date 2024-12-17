import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.cartItems});

  final List<Map<String, dynamic>> cartItems;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _updateQuantity(int index, bool increment) {
    setState(() {
      if (increment) {
        widget.cartItems[index]['quantity']++;
      } else {
        if (widget.cartItems[index]['quantity'] > 1) {
          widget.cartItems[index]['quantity']--;
        } else {
          widget.cartItems.removeAt(index); // Remove item if quantity is 0
        }
      }
    });
  }

  void _proceedToCheckout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Proceeding to checkout..."),
      ),
    );

    // Navigate to checkout page or handle further logic
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CheckoutPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cartItems.fold(
      0,
      (sum, item) =>
          sum + (item['product'].price * item['quantity'] as double),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final product = widget.cartItems[index]['product'];
                final quantity = widget.cartItems[index]['quantity'];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(product.image),
                    radius: 25,
                  ),
                  title: Text(product.name),
                  subtitle: Text(
                    "Price: \$${product.price.toStringAsFixed(2)} x $quantity = \$${(product.price * quantity).toStringAsFixed(2)}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _updateQuantity(index, false),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text("$quantity"),
                      IconButton(
                        onPressed: () => _updateQuantity(index, true),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Total: \$${totalPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => _proceedToCheckout(context),
                  icon: const Icon(Icons.payment),
                  label: const Text("Proceed to Checkout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Mock Checkout Page
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: const Center(
        child: Text("Checkout Page - Implement your checkout functionality here"),
      ),
    );
  }
}

