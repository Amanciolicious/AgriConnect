// admin_feedback.dart
import 'package:agri_app/pages/customer-side/data/feedback_storage.dart';
import 'package:flutter/material.dart';

class AdminFeedback extends StatefulWidget {
  const AdminFeedback({super.key});

  @override
  State<AdminFeedback> createState() => _AdminFeedbackState();
}

class _AdminFeedbackState extends State<AdminFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback Management"),
        centerTitle: true,
      ),
      body: StreamBuilder<Object>(
        stream: Stream.periodic(const Duration(seconds: 1), (x) => x),
        builder: (context, snapshot) {
          final feedbacks = FeedbackStorage.getCustomerFeedback();
          
          if (feedbacks.isEmpty) {
            return const Center(
              child: Text(
                "No feedback yet",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              final feedback = feedbacks[index];
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.feedback, color: Colors.blue),
                    title: Text("Feedback #${index + 1}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(feedback.message),
                        const SizedBox(height: 4),
                        Text(
                          'Submitted on: ${feedback.timestamp.toString().split('.')[0]}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          FeedbackStorage.deleteFeedback(feedback.id);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Feedback deleted'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}