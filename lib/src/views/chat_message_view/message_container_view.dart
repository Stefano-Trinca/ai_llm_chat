import 'package:ai_llm_chat/flutter_ai_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/theme_utils.dart';
import '../../views/jumping_dots_progress_indicator/jumping_dots_progress_indicator.dart';
import 'hovering_buttons.dart';

/// A widget that displays a chat message container with customizable appearance and content.
class MessageContainerView extends StatelessWidget {
  /// The [MessageContainerView] can display either a user message or a system message,
  /// and supports optional editing, custom styles, and response building.
  ///
  /// Parameters:
  /// - [text]: The main message text to display.
  /// - [statusMessage]: An optional status message (e.g., "sending...", "failed").
  /// - [isUserMessage]: Whether the message is from the user (true) or from the system/AI (false).
  /// - [onEdit]: Optional callback triggered when the message is to be edited.
  /// - [chatStyle]: The style configuration for the chat view.
  /// - [styleSheet]: Optional custom Markdown style sheet for rendering the message.
  /// - [responseBuilder]: Optional builder for customizing the response widget.
  /// - [isWelcomeMessage]: Whether this message is a welcome message.
  const MessageContainerView({
    super.key,
    required this.message,
    this.streamText,
    this.onEdit,
    required this.chatStyle,
    this.styleSheet,
    this.responseBuilder,
    this.isWelcomeMessage = false,
  });

  /// The message that this container displays
  final ChatMessage message;

  final Stream<String>? streamText;

  /// Callback triggered when the edit action is performed on the message.
  final VoidCallback? onEdit;

  /// The style configuration for the chat view.
  final LlmChatViewStyle chatStyle;

  /// Custom Markdown style sheet for rendering the message text.
  final MarkdownStyleSheet? styleSheet;

  /// Optional builder for customizing the response widget.
  final Widget Function(BuildContext, String)? responseBuilder;

  /// Indicates if this message is a welcome message.
  final bool isWelcomeMessage;

  @override
  Widget build(BuildContext context) {
    final messageStyle =
        message.origin.isUser
            ? chatStyle.userMessageStyle ?? MessageStyle.contextUser(context)
            : chatStyle.llmMessageStyle ?? MessageStyle.contextLLM(context);

    if (message.status == 'streaming' && streamText != null) {
      return StreamBuilder<String>(
        stream: streamText,
        builder: (context, snapshot) {
          final text = snapshot.data;
          final statusMessage = message.statusMessage;
          return _buildView(
            context,
            isUserMessage: message.origin.isUser,
            messageStyle: messageStyle,
            text: text,
            statusMessage: statusMessage,
          );
        },
      );
    } else {
      return _buildView(
        context,
        isUserMessage: message.origin.isUser,
        messageStyle: messageStyle,
        text: message.text,
        statusMessage: message.statusMessage,
      );
    }
  }

  Widget _buildView(
    BuildContext context, {
    required bool isUserMessage,
    required MessageStyle messageStyle,
    required String? text,
    required String? statusMessage,
  }) {
    /// status message
    if (text == null && statusMessage != null) {
      return Padding(
        padding: (messageStyle.padding ?? EdgeInsets.zero).copyWith(bottom: 24),
        child: Shimmer.fromColors(
          baseColor:
              messageStyle.statusMessageShimmerColors?.$1 ??
              context.colorScheme.onSurfaceVariant.withAlpha(120),
          highlightColor:
              messageStyle.statusMessageShimmerColors?.$2 ??
              context.colorScheme.onSurfaceVariant,
          child: Text(statusMessage, style: messageStyle.statusMessageStyle),
        ),
      );
    }

    return HoveringButtons(
      isUserMessage: isUserMessage,
      chatStyle: chatStyle,
      clipboardText: text,
      onEdit: onEdit,
      child: Container(
        decoration: messageStyle.decoration,
        padding: messageStyle.padding,
        child:
            text == null
                ? SizedBox(
                  width: 40,
                  child: JumpingDotsProgressIndicator(
                    fontSize: 40,
                    color: chatStyle.progressIndicatorColor!,
                  ),
                )
                : isWelcomeMessage || responseBuilder == null
                ? MarkdownBody(
                  data: text,
                  selectable: false,
                  styleSheet: styleSheet,
                )
                : responseBuilder!(context, text),
      ),
    );
  }
}
