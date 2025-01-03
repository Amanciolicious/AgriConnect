import 'package:flutter/material.dart';
import 'package:agri_app/pages/customer-side/data/feedback_storage.dart';
import 'package:agri_app/pages/customer-side/models/ag_theme.dart';
import 'package:agri_app/pages/database-inputs/messages.dart'; // Import Message model

class AdminFeedback extends StatefulWidget {
  const AdminFeedback({super.key});

  @override
  State<AdminFeedback> createState() => _AdminFeedbackState();
}

class _AdminFeedbackState extends State<AdminFeedback> {
  @override
  Widget build(BuildContext context) {
    const adminId = "admin123"; // Replace with the actual admin ID

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AgTheme.primaryGreen,
        title: const Row(
          children: [
            Icon(Icons.agriculture, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Harvest Dashboard",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Message>>(
        stream: FeedbackStorage.getCustomerFeedback(adminId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.grass_outlined,
                    size: 64,
                    color: AgTheme.primaryGreen,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "The field is empty.\nWaiting for feedback to grow!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: AgTheme.earthBrown,
                    ),
                  ),
                ],
              ),
            );
          }

          final feedbacks = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              final feedback = feedbacks[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                    color: AgTheme.lightGreen,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: AgTheme.lightGreen.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.eco, color: AgTheme.primaryGreen),
                          const SizedBox(width: 8),
                          Text(
                            "Feedback #${index + 1}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AgTheme.primaryGreen,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () async {
                              await FeedbackStorage.deleteFeedback(feedback.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Feedback removed from the field'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feedback.message,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: AgTheme.earthBrown,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Planted on: ${feedback.createdAt.toString().split('.')[0]}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AgTheme.earthBrown,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
