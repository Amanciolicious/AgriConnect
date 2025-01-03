import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agri_app/pages/database-inputs/messages.dart';

class FeedbackStorage {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add customer feedback
  static Future<void> addCustomerFeedback(String message, String senderId, String receiverId) async {
    final feedback = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      isRead: false, // Feedback is unread by default
      message: message,
      senderId: senderId,
      receiverId: receiverId,
    );

    // Store feedback in Firestore
    await _firestore.collection('feedbacks').doc(feedback.id).set(feedback.toMap());
  }

  // Retrieve customer feedback
  static Stream<List<Message>> getCustomerFeedback(String receiverId) {
    return _firestore
        .collection('feedbacks')
        .where('receiverId', isEqualTo: receiverId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Message.fromMap(doc.data()))
            .toList());
  }

  // Mark feedback as read
  static Future<void> markFeedbackAsRead(String feedbackId) async {
    await _firestore.collection('feedbacks').doc(feedbackId).update({'isRead': true});
  }

  // Delete feedback
  static Future<void> deleteFeedback(String id) async {
    await _firestore.collection('feedbacks').doc(id).delete();
  }
}
