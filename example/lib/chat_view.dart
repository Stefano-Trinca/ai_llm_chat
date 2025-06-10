import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'provider.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return LlmChatView(
      provider: TestLlmProvider(),
      enableAttachments: false,
      enableVoiceNotes: false,
    );
  }
}
