/// Message Model
/// Represents a single chat message with sender info, content, and timestamp
class Message {
  final String sender; // Name of the sender
  final String text; // Message content
  final DateTime timestamp; // When message was sent
  final bool isUser; // true if message is from user, false if from friend/bot

  Message({
    required this.sender,
    required this.text,
    required this.timestamp,
    required this.isUser,
  });

  /// Convert message to JSON format (useful for future persistence)
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'isUser': isUser,
    };
  }

  /// Create message from JSON format
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'] as String,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isUser: json['isUser'] as bool,
    );
  }
}
