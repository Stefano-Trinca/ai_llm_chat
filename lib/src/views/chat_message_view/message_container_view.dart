import 'package:ai_llm_chat/flutter_ai_toolkit.dart';
import 'package:ai_llm_chat/src/chat_view_model/chat_view_model_client.dart';
import 'package:ai_llm_chat/src/views/chat_message_view/adaptive_copy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/theme_utils.dart';

/// A widget that displays a chat message container with customizable appearance and content.
///
/// The [MessageContainerView] can display either a user message or a system message,
/// and supports optional editing, custom styles, and response building.
class MessageContainerView extends StatelessWidget {
  const MessageContainerView({
    super.key,
    required this.message,
    this.streamText,
    this.onEdit,
    required this.chatStyle,
    this.styleSheet,
    this.responseBuilder,
    this.isWelcomeMessage = false,
    this.builderMessageHeader,
    this.builderMessageFooter,
    this.userMessageActions = const [],
    this.llmMessageActions = const [],
  });

  /// The message that this container displays
  final ChatMessage message;

  /// An optional stream of text for streaming messages.
  final Stream<String>? streamText;

  /// Callback triggered when the edit action is performed on the message.
  final VoidCallback? onEdit;

  /// The style configuration for the chat view.
  final LlmChatViewStyle chatStyle;

  /// Custom Markdown style sheet for rendering the message text.
  final MarkdownStyleSheet? styleSheet;

  /// Optional builder for customizing the response widget.
  final Widget Function(BuildContext, String)? responseBuilder;

  /// Optional builder for the message header to show above the message container
  final Widget Function(
    BuildContext context,
    ChatMessage message,
    Map<String, dynamic> metadata,
  )?
  builderMessageHeader;

  /// Optional builder for the message footer to show below the message container
  final Widget Function(
    BuildContext context,
    ChatMessage message,
    Map<String, dynamic> metadata,
  )?
  builderMessageFooter;

  /// Optional [MessageAction] for the user message
  final List<MessageAction> userMessageActions;

  /// Optional [MessageAction] for the LLM message
  final List<MessageAction> llmMessageActions;

  /// Indicates if this message is a welcome message.
  final bool isWelcomeMessage;

  @override
  Widget build(BuildContext context) {
    final isUserMessage = message.origin.isUser;
    final messageStyle =
        isUserMessage
            ? chatStyle.userMessageStyle ?? MessageStyle.contextUser(context)
            : chatStyle.llmMessageStyle ?? MessageStyle.contextLLM(context);

    final isStreaming = message.status == 'streaming' && streamText != null;

    if (isStreaming) {
      return _StreamingMessageView(
        streamText: streamText!,
        message: message,
        isUserMessage: isUserMessage,
        messageStyle: messageStyle,
        chatStyle: chatStyle,
        styleSheet: styleSheet,
        responseBuilder: responseBuilder,
        isWelcomeMessage: isWelcomeMessage,
        builderMessageHeader: builderMessageHeader,
        builderMessageFooter: builderMessageFooter,
        onEdit: onEdit,
        actions: isUserMessage ? userMessageActions : llmMessageActions,
      );
    }

    return _MessageView(
      message: message,
      isUserMessage: isUserMessage,
      messageStyle: messageStyle,
      chatStyle: chatStyle,
      styleSheet: styleSheet,
      responseBuilder: responseBuilder,
      isWelcomeMessage: isWelcomeMessage,
      builderMessageHeader: builderMessageHeader,
      builderMessageFooter: builderMessageFooter,
      onEdit: onEdit,
      actions: isUserMessage ? userMessageActions : llmMessageActions,
    );
  }
}

/// Widget separato per messaggi in streaming - evita rebuild inutili
class _StreamingMessageView extends StatelessWidget {
  const _StreamingMessageView({
    required this.streamText,
    required this.message,
    required this.isUserMessage,
    required this.messageStyle,
    required this.chatStyle,
    required this.actions,
    this.styleSheet,
    this.responseBuilder,
    this.isWelcomeMessage = false,
    this.builderMessageHeader,
    this.builderMessageFooter,
    this.onEdit,
  });

  final Stream<String> streamText;
  final ChatMessage message;
  final bool isUserMessage;
  final MessageStyle messageStyle;
  final LlmChatViewStyle chatStyle;
  final List<MessageAction> actions;
  final MarkdownStyleSheet? styleSheet;
  final Widget Function(BuildContext, String)? responseBuilder;
  final bool isWelcomeMessage;
  final Widget Function(BuildContext, ChatMessage, Map<String, dynamic>)?
  builderMessageHeader;
  final Widget Function(BuildContext, ChatMessage, Map<String, dynamic>)?
  builderMessageFooter;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: streamText,
      builder: (context, snapshot) {
        return _MessageView(
          message: message.copyWith(text: snapshot.data),
          isUserMessage: isUserMessage,
          messageStyle: messageStyle,
          chatStyle: chatStyle,
          styleSheet: styleSheet,
          responseBuilder: responseBuilder,
          isWelcomeMessage: isWelcomeMessage,
          builderMessageHeader: builderMessageHeader,
          builderMessageFooter: builderMessageFooter,
          onEdit: onEdit,
          actions: actions,
        );
      },
    );
  }
}

/// Widget separato per la vista del messaggio - permette optimizzazioni
class _MessageView extends StatelessWidget {
  const _MessageView({
    required this.message,
    required this.isUserMessage,
    required this.messageStyle,
    required this.chatStyle,
    required this.actions,
    this.styleSheet,
    this.responseBuilder,
    this.isWelcomeMessage = false,
    this.builderMessageHeader,
    this.builderMessageFooter,
    this.onEdit,
  });

  final ChatMessage message;
  final bool isUserMessage;
  final MessageStyle messageStyle;
  final LlmChatViewStyle chatStyle;
  final List<MessageAction> actions;
  final MarkdownStyleSheet? styleSheet;
  final Widget Function(BuildContext, String)? responseBuilder;
  final bool isWelcomeMessage;
  final Widget Function(BuildContext, ChatMessage, Map<String, dynamic>)?
  builderMessageHeader;
  final Widget Function(BuildContext, ChatMessage, Map<String, dynamic>)?
  builderMessageFooter;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final text = message.text;

    // Handle status messages (loading state)
    if (text == null) {
      return _StatusMessage(messageStyle: messageStyle);
    }

    // Build message content
    final messageContent = _MessageContent(
      text: text,
      chatStyle: chatStyle,
      styleSheet: styleSheet,
      responseBuilder: responseBuilder,
      isWelcomeMessage: isWelcomeMessage,
      onEdit: onEdit,
    );

    // Wrap with metadata if needed
    final fullContent = _MessageWithMetadata(
      message: message,
      builderMessageHeader: builderMessageHeader,
      builderMessageFooter: builderMessageFooter,
      child: messageContent,
    );

    return MessageContainerActions(
      message: message,
      isUserMessage: isUserMessage,
      chatStyle: chatStyle,
      showOnHover: false,
      actions: actions,
      child: Container(
        decoration: messageStyle.decoration,
        padding: messageStyle.padding,
        child: fullContent,
      ),
    );
  }
}

/// Widget separato per il messaggio di stato - evita rebuild quando non necessario
class _StatusMessage extends StatelessWidget {
  const _StatusMessage({required this.messageStyle});

  final MessageStyle messageStyle;

  @override
  Widget build(BuildContext context) {
    return ChatViewModelClient(
      builder: (context, viewModel, child) {
        return ValueListenableBuilder(
          valueListenable: viewModel.provider.listenableStatus,
          builder: (context, status, child) {
            final baseColor =
                messageStyle.statusMessageShimmerColors?.$1 ??
                context.colorScheme.onSurfaceVariant.withAlpha(120);
            final highlightColor =
                messageStyle.statusMessageShimmerColors?.$2 ??
                context.colorScheme.onSurfaceVariant;

            return Padding(
              padding: (messageStyle.padding ?? EdgeInsets.zero).copyWith(
                bottom: 24,
              ),
              child: Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Text(
                  viewModel.provider.statusMessage,
                  style: messageStyle.statusMessageStyle,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// Widget separato per il contenuto del messaggio - può essere const se il testo non cambia
class _MessageContent extends StatelessWidget {
  const _MessageContent({
    required this.text,
    required this.chatStyle,
    required this.isWelcomeMessage,
    this.styleSheet,
    this.responseBuilder,
    this.onEdit,
  });

  final String text;
  final LlmChatViewStyle chatStyle;
  final MarkdownStyleSheet? styleSheet;
  final Widget Function(BuildContext, String)? responseBuilder;
  final bool isWelcomeMessage;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final shouldUseMarkdown = isWelcomeMessage || responseBuilder == null;

    return AdaptiveCopyText(
      clipboardText: text,
      chatStyle: chatStyle,
      onEdit: onEdit,
      child:
          shouldUseMarkdown
              ? MarkdownBody(
                data: text,
                selectable: false,
                styleSheet: styleSheet,
              )
              : responseBuilder!(context, text),
    );
  }
}

/// Widget separato per header/footer metadata - rebuild solo quando metadata cambia
class _MessageWithMetadata extends StatelessWidget {
  const _MessageWithMetadata({
    required this.message,
    required this.child,
    this.builderMessageHeader,
    this.builderMessageFooter,
  });

  final ChatMessage message;
  final Widget child;
  final Widget Function(BuildContext, ChatMessage, Map<String, dynamic>)?
  builderMessageHeader;
  final Widget Function(BuildContext, ChatMessage, Map<String, dynamic>)?
  builderMessageFooter;

  @override
  Widget build(BuildContext context) {
    final hasHeader =
        message.headerMetadata.isNotEmpty && builderMessageHeader != null;
    final hasFooter =
        message.metadata.isNotEmpty && builderMessageFooter != null;

    if (!hasHeader && !hasFooter) {
      return child;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasHeader)
          builderMessageHeader!(context, message, message.headerMetadata),
        child,
        if (hasFooter)
          builderMessageFooter!(context, message, message.metadata),
      ],
    );
  }
}

/// A wrapper widget that manages action buttons for a message container
class MessageContainerActions extends StatefulWidget {
  const MessageContainerActions({
    super.key,
    required this.message,
    required this.actions,
    required this.child,
    required this.isUserMessage,
    required this.chatStyle,
    this.showOnHover = false,
  });

  static const double _iconSize = 16.0;
  static const double _alwaysShownBottomPadding = _iconSize + 12;
  static const double _hoverBottomPadding = _iconSize + 2;
  static const double _leftOffset = 12.0;
  static const double _hoverLeftOffset = 32.0;

  final Widget child;
  final bool isUserMessage;
  final bool showOnHover;
  final LlmChatViewStyle chatStyle;
  final List<MessageAction> actions;
  final ChatMessage message;

  @override
  State<MessageContainerActions> createState() =>
      _MessageContainerActionsState();
}

class _MessageContainerActionsState extends State<MessageContainerActions> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    if (widget.actions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(
          bottom: MessageContainerActions._hoverBottomPadding,
        ),
        child: widget.child,
      );
    }

    final actionsRow = _buildActionsRow();

    return widget.showOnHover
        ? _buildHoverActions(actionsRow)
        : _buildAlwaysShownActions(actionsRow);
  }

  /// Builds the row of action buttons
  Widget _buildActionsRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 0,
      children: [
        for (final action in widget.actions)
          MessageContainerActionButton(
            key: ValueKey(action.label),
            action: action,
            message: widget.message,
          ),
      ],
    );
  }

  /// Builds actions that are always visible
  Widget _buildAlwaysShownActions(Widget actionsRow) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: MessageContainerActions._alwaysShownBottomPadding,
          ),
          child: widget.child,
        ),
        Positioned(
          bottom: 0,
          right: widget.isUserMessage ? 0 : null,
          left:
              widget.isUserMessage ? null : MessageContainerActions._leftOffset,
          child: actionsRow,
        ),
      ],
    );
  }

  /// Builds actions that are shown only on hover
  Widget _buildHoverActions(Widget actionsRow) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: MessageContainerActions._hoverBottomPadding,
            ),
            child: widget.child,
          ),
          if (_hovering)
            Positioned(
              bottom: 0,
              right: widget.isUserMessage ? 0 : null,
              left:
                  widget.isUserMessage
                      ? null
                      : MessageContainerActions._hoverLeftOffset,
              child: actionsRow,
            ),
        ],
      ),
    );
  }
}

/// A single action button for a message container
class MessageContainerActionButton extends StatelessWidget {
  const MessageContainerActionButton({
    super.key,
    required this.action,
    required this.message,
  });

  static const double _iconSize = 16.0;
  static const EdgeInsets _padding = EdgeInsets.all(4.0);

  final MessageAction action;
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: action.label,
      child: InkWell(
        onTap: () => action.onPressed?.call(message),
        child: Padding(
          padding: _padding,
          child: Icon(action.icon, size: _iconSize),
        ),
      ),
    );
  }
}
