import 'package:flutter/foundation.dart';
import 'package:llama_flutter_integration/services/ai_service.dart';
import '../models/chat_message.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  final AiService _aiService = AiService();
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String content) async {
    _messages.add(ChatMessage(
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    ));
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _aiService.generateResponse(content);
      _messages.add(ChatMessage(
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      debugPrint('Error generating response: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
