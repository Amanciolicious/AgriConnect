// customer_feedback.dart
import 'package:agri_app/pages/customer-side/data/feedback_storage.dart';
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
      appBar: AppBar(
        title: const Text("Submit Feedback"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "We value your feedback!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Write your feedback here...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_feedbackController.text.trim().isNotEmpty) {
                    FeedbackStorage.addCustomerFeedback(_feedbackController.text);
                    _feedbackController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Feedback submitted successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}