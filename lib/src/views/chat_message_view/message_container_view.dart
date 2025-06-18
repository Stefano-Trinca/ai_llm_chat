import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:flutter_ai_toolkit/src/utils/theme_utils.dart';
import 'package:flutter_ai_toolkit/src/views/jumping_dots_progress_indicator/jumping_dots_progress_indicator.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:shimmer/shimmer.dart';

import 'adaptive_copy_text.dart';
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
    this.text,
    this.statusMessage,
    required this.isUserMessage,
    this.onEdit,
    required this.chatStyle,
    this.styleSheet,
    this.responseBuilder,
    this.isWelcomeMessage = false,
  });

  /// The main text content of the chat message.
  final String? text;

  /// An optional status message associated with the chat message (e.g., "sending", "delivered").
  final String? statusMessage;

  /// Indicates whether the message was sent by the user.
  final bool isUserMessage;

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
        isUserMessage
            ? chatStyle.userMessageStyle ?? MessageStyle.contextUser(context)
            : chatStyle.llmMessageStyle ?? MessageStyle.contextLLM(context);

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
          child: Text(statusMessage!, style: messageStyle.statusMessageStyle),
        ),
      );
    }

    // message container
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
                : AdaptiveCopyText(
                  chatStyle: chatStyle,
                  clipboardText: text ?? '',
                  onEdit: onEdit,
                  child:
                      isWelcomeMessage || responseBuilder == null
                          ? MarkdownBody(
                            data: text ?? '',
                            selectable: false,
                            styleSheet: styleSheet,
                          )
                          : responseBuilder!(context, text ?? ''),
                ),
      ),
    );
  }
}
