import 'package:flutter/material.dart';
import 'package:ai_llm_chat/flutter_ai_toolkit.dart';
import 'package:solar_icons/solar_icons.dart';

import 'provider.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return LlmChatView(
      provider: TestLlmProvider(),
      enableAttachments: false,
      enableVoiceNotes: false,
      enableCancel: true,
      // advertisingMessage:
      //     'Questo assistente può commettere errori. Non fidarti ciecamente delle sue risposte.',
      style: LlmChatViewStyle.context(context).copyWith(
        llmMessageStyle: MessageStyle.contextLLM(context).copyWith(
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
          showAvatar: false,
        ),
        submitButtonStyle: ActionButtonStyle.context(
          context,
          ActionButtonType.submit,
        ).copyWith(icon: SolarIconsOutline.arrowToTopLeft),
        disabledButtonStyle: ActionButtonStyle.context(
          context,
          ActionButtonType.disabled,
        ).copyWith(icon: SolarIconsOutline.arrowToTopLeft),
        chatInputStyle: ChatInputStyle.context(
          context,
        ).copyWith(hintText: 'Scrivi il tuo messaggio...'),
      ),
      emptyBuilder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Assistente LLM',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 12),
            Text(
              'Come posso aiutarti oggi?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        );
      },
    );
  }
}
