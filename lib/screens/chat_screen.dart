import 'package:flutter/material.dart';
import 'package:llama_flutter_integration/providers/chat_provider.dart';
import 'package:llama_flutter_integration/utils/chat_bubble.dart';
import 'package:llama_flutter_integration/utils/chat_input.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messages[index];
                return ChatBubble(
                  message: message.content,
                  isUser: message.isUser,
                );
              },
            ),
          ),
          if (chatProvider.isLoading) const CircularProgressIndicator(),
          ChatInput(
            onSend: (content) => chatProvider.sendMessage(content),
          ),
        ],
      ),
    );
  }
}
