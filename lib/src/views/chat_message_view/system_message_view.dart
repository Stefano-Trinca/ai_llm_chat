// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../chat_view_model/chat_view_model_client.dart';
import '../../providers/interface/chat_message.dart';
import '../../styles/styles.dart';
import '../../utils/theme_utils.dart';

/// A widget that displays a system message in the chat, centered horizontally.
///
/// System messages are informational banners (e.g. "Chat started", timestamps,
/// connection events) and are visually distinct from user and LLM messages:
/// they are centered, use a pill-shaped container, and have no avatar or
/// action buttons.
@immutable
class SystemMessageView extends StatelessWidget {
  /// Creates a [SystemMessageView].
  const SystemMessageView(this.message, {super.key});

  /// The system chat message to be displayed.
  final ChatMessage message;

  @override
  Widget build(BuildContext context) => ChatViewModelClient(
    builder: (context, viewModel, child) {
      final chatStyle = LlmChatViewStyle.resolve(viewModel.style);
      final systemStyle =
          chatStyle.systemMessageStyle ?? MessageStyle.contextSystem(context);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Center(
          child: _SystemMessageContent(
            message: message,
            style: systemStyle,
            chatStyle: chatStyle,
          ),
        ),
      );
    },
  );
}

class _SystemMessageContent extends StatelessWidget {
  const _SystemMessageContent({
    required this.message,
    required this.style,
    required this.chatStyle,
  });

  final ChatMessage message;
  final MessageStyle style;
  final LlmChatViewStyle chatStyle;

  @override
  Widget build(BuildContext context) {
    final text = message.text ?? '';

    // Show shimmer when there is no text but a statusMessage is present
    if (text.isEmpty && message.statusMessage.isNotEmpty) {
      final baseColor =
          style.statusMessageShimmerColors?.$1 ??
          context.colorScheme.onSurfaceVariant.withAlpha(120);
      final highlightColor =
          style.statusMessageShimmerColors?.$2 ??
          context.colorScheme.onSurfaceVariant;

      return Container(
        decoration: style.decoration,
        padding: style.padding,
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Text(
            message.statusMessage,
            style: style.statusMessageStyle,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (text.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: style.decoration,
      padding: style.padding,
      child: Text(
        text,
        style: style.textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
