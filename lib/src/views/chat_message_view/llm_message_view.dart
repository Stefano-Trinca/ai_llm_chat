// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ai_toolkit/src/views/chat_message_view/avatar_message_view.dart';
import 'package:flutter_ai_toolkit/src/views/chat_message_view/message_row_view.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../../chat_view_model/chat_view_model_client.dart';
import '../../providers/interface/chat_message.dart';
import '../../styles/llm_chat_view_style.dart';
import '../../styles/llm_message_style.dart';
import '../jumping_dots_progress_indicator/jumping_dots_progress_indicator.dart';
import 'adaptive_copy_text.dart';
import 'hovering_buttons.dart';

/// A widget that displays an LLM (Language Model) message in a chat interface.
@immutable
class LlmMessageView extends StatelessWidget {
  /// Creates an [LlmMessageView].
  ///
  /// The [message] parameter is required and represents the LLM chat message to
  /// be displayed.
  const LlmMessageView(
    this.message, {
    this.isWelcomeMessage = false,
    super.key,
  });

  /// The LLM chat message to be displayed.
  final ChatMessage message;

  /// Whether the message is the welcome message.
  final bool isWelcomeMessage;

  @override
  Widget build(BuildContext context) => ChatViewModelClient(
    builder: (context, viewModel, child) {
      final text = message.text;
      final chatStyle = LlmChatViewStyle.resolve(viewModel.style);
      final llmStyle = LlmMessageStyle.resolve(chatStyle.llmMessageStyle);

      final avatar =
          llmStyle.showAvatar
              ? AvatarMessageView(style: llmStyle.avatarStyle)
              : null;

      final messageContaner = HoveringButtons(
        isUserMessage: false,
        chatStyle: chatStyle,
        clipboardText: text,
        child: Container(
          decoration: llmStyle.decoration,
          padding: const EdgeInsets.all(8),
          child:
              text == null
                  ? SizedBox(
                    width: 40,
                    child: JumpingDotsProgressIndicator(
                      fontSize: 40,
                      color: chatStyle.progressIndicatorColor!,
                    ),
                  )
                  : AdaptiveCopyText(
                    clipboardText: text,
                    chatStyle: chatStyle,
                    child:
                        isWelcomeMessage || viewModel.responseBuilder == null
                            ? MarkdownBody(
                              data: text,
                              selectable: false,
                              styleSheet: llmStyle.markdownStyle,
                            )
                            : viewModel.responseBuilder!(context, text),
                  ),
        ),
      );

      return MessageRowView(
        align: MessageAlign.left,
        messageFlex: (6, 1),
        avatar: avatar,
        messageContainer: messageContaner,
      );
    },
  );
}
