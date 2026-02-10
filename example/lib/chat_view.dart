import 'package:ai_llm_chat/flutter_ai_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

import 'provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final TestLlmProvider provider;

  @override
  void initState() {
    super.initState();
    provider = TestLlmProvider();
  }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LlmChatView(
      provider: provider,
      enableAttachments: false,
      enableVoiceNotes: true,
      enableCancel: true,
      suggestions: ['Suggerimento 1', 'Suggerimento 2'],

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
        recordButtonStyle: ActionButtonStyle.context(
          context,
          ActionButtonType.record,
        ).copyWith(icon: SolarIconsOutline.microphone2),
        stopButtonStyle: ActionButtonStyle.context(
          context,
          ActionButtonType.stop,
        ).copyWith(icon: SolarIconsOutline.stop),
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
            InputChip(
              label: Text('Esempio: "Qual è il tempo a Roma?"'),
              onPressed: () {
                provider.textInputController.text = 'Qual è il tempo a Roma?';
                provider.inputFocusNode.requestFocus();
                print(
                  "provider textcontroller = ${provider.textInputController.text}",
                );
              },
            ),
          ],
        );
      },

      inputTrailingWidget: IconButton(
        onPressed: () {},
        icon: Icon(SolarIconsOutline.menuDots),
      ),

      builderMessageFooter: (context, message, metadata) {
        final source = metadata['source'] ?? 'Sconosciuto';
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Icon(SolarIconsOutline.link, size: 16),
              SizedBox(width: 4),
              Text(
                'Fonte: $source',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
      llmMessageActions: [
        MessageAction(
          icon: Icons.copy_rounded,
          label: 'Copia',
          onPressed: (message) => print('Copia LLM: ${message.text}'),
        ),
      ],
      userMessageActions: [
        // MessageAction(
        //   icon: Icons.copy_rounded,
        //   label: 'Copia',
        //   onPressed: (message) => print('Copia User: ${message.text}'),
        // ),
      ],
    );
  }
}
