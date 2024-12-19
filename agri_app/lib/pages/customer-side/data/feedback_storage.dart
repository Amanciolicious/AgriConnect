// feedback_storage.dart
import 'package:agri_app/pages/customer-side/models/feedback.dart';

class FeedbackStorage {
  static final List<FeedbackModel> _customerFeedbackList = [];
  static final List<FeedbackModel> _adminFeedbackList = [];

  // Add customer feedback
  static void addCustomerFeedback(String feedback) {
    final newFeedback = FeedbackModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: feedback,
      timestamp: DateTime.now(),
    );
    _customerFeedbackList.add(newFeedback);
  }

  // Add admin feedback
  static void addAdminFeedback(String feedback) {
    final newFeedback = FeedbackModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: feedback,
      timestamp: DateTime.now(),
    );
    _adminFeedbackList.add(newFeedback);
  }

  // Retrieve customer feedback
  static List<FeedbackModel> getCustomerFeedback() {
    return List.from(_customerFeedbackList);
  }

  // Retrieve admin feedback
  static List<FeedbackModel> getAdminFeedback() {
    return List.from(_adminFeedbackList);
  }

  // Delete feedback
  static void deleteFeedback(String id) {
    _customerFeedbackList.removeWhere((feedback) => feedback.id == id);
    _adminFeedbackList.removeWhere((feedback) => feedback.id == id);
  }
}