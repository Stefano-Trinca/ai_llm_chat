// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import '../../views/chat_message_view/message_container_view.dart';
import '../../views/chat_message_view/message_row_view.dart';

import '../../chat_view_model/chat_view_model_client.dart';
import '../../providers/interface/chat_message.dart';
import '../../styles/styles.dart';
import 'avatar_message_view.dart';

/// A widget that displays a user's message in a chat interface.
///
/// This widget is responsible for rendering the user's message, including any
/// attachments, in a right-aligned layout. It uses a [Row] and [Column] to
/// structure the content, with the message text displayed in a styled
/// container.
@immutable
class UserMessageView extends StatelessWidget {
  /// Creates a [UserMessageView].
  ///
  /// The [message] parameter is required and contains the [ChatMessage] to be
  /// displayed.
  const UserMessageView(this.message, {super.key, this.onEdit});

  /// The chat message to be displayed.
  final ChatMessage message;

  /// The callback to be invoked when the message is edited.
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) => ChatViewModelClient(
    builder: (context, viewModel, child) {
      final chatStyle = LlmChatViewStyle.resolve(viewModel.style);
      final userStyle =
          chatStyle.userMessageStyle ?? MessageStyle.contextUser(context);

      final avatar =
          userStyle.showAvatar
              ? AvatarMessageView(style: userStyle.avatarStyle)
              : null;

      final messageContainer = MessageContainerView(
        message: message,
        chatStyle: chatStyle,
        styleSheet: userStyle.markdownStyle,
        onEdit: onEdit,
        responseBuilder: viewModel.responseBuilder,
      );

      return MessageRowView(
        align: MessageAlign.right,
        attachments: message.attachments,
        avatar: avatar,
        messageContainer: messageContainer,
      );
    },
  );
}
