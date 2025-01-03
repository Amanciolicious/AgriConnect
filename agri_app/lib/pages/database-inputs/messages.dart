class Message {
  final String id;
  final String message;
  final String senderId;
  final String receiverId;
  final DateTime createdAt;
  final bool isRead;

  Message({
    required this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
    required this.isRead,
  });

  // Convert a Message object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  // Convert a Firestore document into a Message object
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      message: map['message'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      createdAt: DateTime.parse(map['createdAt']),
      isRead: map['isRead'],
    );
  }
}
