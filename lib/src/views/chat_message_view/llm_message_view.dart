// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../providers/interface/chat_message.dart';
import '../../styles/styles.dart';
import '../../views/chat_message_view/avatar_message_view.dart';
import '../../views/chat_message_view/message_row_view.dart';

import '../../chat_view_model/chat_view_model_client.dart';
import 'message_container_view.dart';

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
      final llmStyle =
          chatStyle.llmMessageStyle ?? MessageStyle.contextLLM(context);

      final avatar =
          llmStyle.showAvatar
              ? AvatarMessageView(style: llmStyle.avatarStyle)
              : null;

      final messageContainer = MessageContainerView(
        text: text,
        isUserMessage: false,
        isWelcomeMessage: isWelcomeMessage,
        chatStyle: chatStyle,
        styleSheet: llmStyle.markdownStyle,
        responseBuilder: viewModel.responseBuilder,
        statusMessage: message.statusMessage,
      );

      return MessageRowView(
        align: MessageAlign.left,
        messageFlex: (6, 1),
        avatar: avatar,
        messageContainer: messageContainer,
      );
    },
  );
}
