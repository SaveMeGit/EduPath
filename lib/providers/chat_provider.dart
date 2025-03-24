// Chat Provider: lib/providers/chat_provider.dart

import 'package:flutter/material.dart';
import '../../models/message_model.dart';
import '../../services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final List<MessageModel> _messages = [];
  final List<MessageModel> _history = [];
  String _subject = 'General';
  String _language = 'English';
  final ChatService _chatService = ChatService();

  List<MessageModel> get messages => _messages;

  List<MessageModel> get history => _history;

  String get subject => _subject;

  String get language => _language;

  void setSubject(String subject) {
    _subject = subject;
    notifyListeners();
  }

  void setLanguage(String language) {
    _language = language;
    notifyListeners();
  }

  Future<void> sendTextMessage(String text) async {
    final userMessage = MessageModel(
      id: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      text: text,
      isUser: true,
      isVoice: false,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    _addToHistory(userMessage);
    notifyListeners();

    // Get response from AI
    try {
      final response = await _chatService.getAIResponse(
        text: text,
        subject: _subject,
        language: _language,
      );

      final botMessage = MessageModel(
        id: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        text: response,
        isUser: false,
        isVoice: false,
        timestamp: DateTime.now(),
      );

      _messages.add(botMessage);
      notifyListeners();
    } catch (e) {
      debugPrint('Error getting AI response: $e');

      final errorMessage = MessageModel(
        id: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        text: 'Sorry, I encountered an error. Please try again.',
        isUser: false,
        isVoice: false,
        timestamp: DateTime.now(),
      );

      _messages.add(errorMessage);
      notifyListeners();
    }
  }

  Future<void> sendVoiceMessage(String transcription) async {
    final userMessage = MessageModel(
      id: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      text: transcription,
      isUser: true,
      isVoice: true,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    _addToHistory(userMessage);
    notifyListeners();

    // Get response from AI
    try {
      final response = await _chatService.getAIResponse(
        text: transcription,
        subject: _subject,
        language: _language,
        responseType: 'voice',
      );

      final botMessage = MessageModel(
        id: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        text: response,
        isUser: false,
        isVoice: true,
        timestamp: DateTime.now(),
      );

      _messages.add(botMessage);
      notifyListeners();
    } catch (e) {
      debugPrint('Error getting AI response: $e');

      final errorMessage = MessageModel(
        id: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        text: 'Sorry, I encountered an error. Please try again.',
        isUser: false,
        isVoice: false,
        timestamp: DateTime.now(),
      );

      _messages.add(errorMessage);
      notifyListeners();
    }
  }

  void _addToHistory(MessageModel message) {
    if (_history.isEmpty || _history.first.text != message.text) {
      _history.insert(0, message);
      if (_history.length > 20) {
        _history.removeLast();
      }
    }
  }

  void clearChat() {
    _messages.clear();
    notifyListeners();
  }
}

