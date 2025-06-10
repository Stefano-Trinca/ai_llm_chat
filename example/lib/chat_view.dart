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
      style: LlmChatViewStyle.resolve(
        LlmChatViewStyle(
          llmMessageStyle: LlmMessageStyle.resolve(
            LlmMessageStyle(
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
            defaultStyle: LlmMessageStyle.context(context),
          ),
        ),
        defaultStyle: LlmChatViewStyle.context(context),
      ),
    );
  }
}
