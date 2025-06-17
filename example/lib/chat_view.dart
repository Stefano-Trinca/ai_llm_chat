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
      style: LlmChatViewStyle.context(context).copyWith(
        llmMessageStyle: LlmMessageStyle.context(context).copyWith(
          decoration: BoxDecoration(
            color: Colors.transparent,
            // border: Border.all(color: theme.colorScheme.outline),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
