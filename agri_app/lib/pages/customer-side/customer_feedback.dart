// customer_feedback.dart
import 'package:agri_app/pages/customer-side/data/feedback_storage.dart';
import 'package:agri_app/pages/customer-side/models/ag_theme.dart';
import 'package:flutter/material.dart';

class CustomerFeedback extends StatefulWidget {
  const CustomerFeedback({super.key});

  @override
  State<CustomerFeedback> createState() => _CustomerFeedbackState();
}

class _CustomerFeedbackState extends State<CustomerFeedback> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AgTheme.primaryGreen,
        title: const Row(
          children: [
            Icon(Icons.eco, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Farm Feedback",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/farm_background.jpg'), // Add a subtle farm background
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.9),
              BlendMode.lighten,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.grass, color: AgTheme.primaryGreen),
                          SizedBox(width: 8),
                          Text(
                            "Share Your Farming Experience",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AgTheme.earthBrown,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Help us grow better together! Your feedback is like seeds for our improvement.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _feedbackController,
                        maxLines: 5,
                        decoration: AgTheme.inputDecoration.copyWith(
                          hintText: "Plant your thoughts here...",
                          prefixIcon: const Icon(Icons.create, color: AgTheme.primaryGreen),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        style: AgTheme.elevatedButtonStyle,
                        onPressed: () {
                          if (_feedbackController.text.trim().isNotEmpty) {
                            FeedbackStorage.addCustomerFeedback(_feedbackController.text);
                            _feedbackController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text('Your feedback has been harvested!'),
                                  ],
                                ),
                                backgroundColor: AgTheme.primaryGreen,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.send),
                        label: const Text("Submit Feedback"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
