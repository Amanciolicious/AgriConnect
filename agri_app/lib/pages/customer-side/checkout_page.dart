import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.cartItems});

  final List<Map<String, dynamic>> cartItems;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  bool _requestDelivery = false;
  String _deliveryAddress = "";
  String _selectedFarm = "Nearest Farm";
  String? _selectedPaymentMethod; // Main payment method
  String? _selectedMobilePayment; // Sub-option for mobile payment

  final List<String> _farms = ["Nearest Farm", "Farm A", "Farm B"]; // Mock farm list
  final List<String> _paymentMethods = [
    "Credit Card",
    "Cash on Delivery",
    "Mobile Payment"
  ]; // Main payment methods

  final List<String> _mobilePaymentOptions = [
    "GCash",
    "PayMaya",
    "GrabPay",
    "ShopeePay"
  ]; // Mobile payment options

  void _confirmOrder() {
    if (_formKey.currentState!.validate()) {
      if (_selectedPaymentMethod == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a payment method.")),
        );
        return;
      }

      if (_selectedPaymentMethod == "Mobile Payment" &&
          _selectedMobilePayment == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a mobile payment option.")),
        );
        return;
      }

      _formKey.currentState!.save();

      String confirmationMessage =
          "Order Confirmed!\nPickup from: $_selectedFarm\nPayment Method: $_selectedPaymentMethod";

      if (_selectedPaymentMethod == "Mobile Payment") {
        confirmationMessage += " ($_selectedMobilePayment)";
      }

      if (_requestDelivery) {
        confirmationMessage += "\nDelivery Address: $_deliveryAddress";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(confirmationMessage),
        ),
      );

      // Navigate to a success page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OrderSuccessPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cartItems.fold(
      0,
      (sum, item) => sum + (item['product'].price * item['quantity']),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order Summary",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                    );
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  "Total Price: \$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Choose a Farm",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedFarm,
                  items: _farms
                      .map((farm) => DropdownMenuItem(
                            value: farm,
                            child: Text(farm),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFarm = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  title: const Text("Request Door-to-Door Delivery"),
                  value: _requestDelivery,
                  onChanged: (value) {
                    setState(() {
                      _requestDelivery = value;
                    });
                  },
                ),
                if (_requestDelivery)
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your delivery address",
                    ),
                    validator: (value) {
                      if (_requestDelivery && (value == null || value.isEmpty)) {
                        return "Please provide a delivery address.";
                      }
                      return null;
                    },
                    onSaved: (value) => _deliveryAddress = value ?? "",
                  ),
                const SizedBox(height: 20),
                const Text(
                  "Select Payment Method",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedPaymentMethod,
                  items: _paymentMethods
                      .map((method) => DropdownMenuItem(
                            value: method,
                            child: Text(method),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                      _selectedMobilePayment = null; // Reset sub-selection
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Choose a payment method",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a payment method.";
                    }
                    return null;
                  },
                ),
                if (_selectedPaymentMethod == "Mobile Payment") ...[
                  const SizedBox(height: 20),
                  const Text(
                    "Select Mobile Payment Option",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedMobilePayment,
                    items: _mobilePaymentOptions
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedMobilePayment = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Choose a mobile payment option",
                    ),
                    validator: (value) {
                      if (_selectedPaymentMethod == "Mobile Payment" &&
                          (value == null || value.isEmpty)) {
                        return "Please select a mobile payment option.";
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _confirmOrder,
                  icon: const Icon(Icons.check_circle),
                  label: const Text("Confirm Order"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Success"),
      ),
      body: const Center(
        child: Text(
          "Your order has been placed successfully!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
