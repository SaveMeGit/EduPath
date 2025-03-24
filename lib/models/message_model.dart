// Message Model: lib/models/message_model.dart

class MessageModel {
  final String id;
  final String text;
  final bool isUser;
  final bool isVoice;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.text,
    required this.isUser,
    required this.isVoice,
    required this.timestamp,
  });
}