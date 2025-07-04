// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../views/chat_input/chat_suggestion_view.dart';

import '../chat_view_model/chat_view_model_client.dart';
import '../providers/interface/chat_message.dart';
import '../providers/interface/message_origin.dart';
import 'chat_message_view/llm_message_view.dart';
import 'chat_message_view/user_message_view.dart';

/// A widget that displays a history of chat messages.
///
/// This widget renders a scrollable list of chat messages, supporting
/// selection and editing of messages. It displays messages in reverse
/// chronological order (newest at the bottom).
@immutable
class ChatHistoryView extends StatefulWidget {
  /// Creates a [ChatHistoryView].
  ///
  /// If [onEditMessage] is provided, it will be called when a user initiates an
  /// edit action on an editable message (typically the last user message in the
  /// history).
  const ChatHistoryView({
    this.onEditMessage,
    required this.onSelectSuggestion,
    this.emptyBuilder,
    super.key,
  });

  /// Optional callback function for editing a message.
  ///
  /// If provided, this function will be called when a user initiates an edit
  /// action on an editable message (typically the last user message in the
  /// history). The function receives the [ChatMessage] to be edited as its
  /// parameter.
  final void Function(ChatMessage message)? onEditMessage;

  /// The callback function to call when a suggestion is selected.
  final void Function(String suggestion) onSelectSuggestion;

  /// Builder for an empty list of messages.
  ///
  /// this widget replace the list view with the messages when the history is empty.
  final Widget Function(BuildContext context)? emptyBuilder;

  @override
  State<ChatHistoryView> createState() => _ChatHistoryViewState();
}

class _ChatHistoryViewState extends State<ChatHistoryView> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
    child: ChatViewModelClient(
      builder: (context, viewModel, child) {
        return ValueListenableBuilder(
          valueListenable: viewModel.provider.listenableHistory,
          builder: (context, history, child) {
            return ValueListenableBuilder(
              valueListenable: viewModel.provider.listenableShowStatusMessage,
              builder: (context, showStatusMessage, child) {
                final showWelcomeMessage = viewModel.welcomeMessage != null;
                final showSuggestions =
                    viewModel.suggestions.isNotEmpty && history.isEmpty;
                final source = [
                  if (showWelcomeMessage)
                    ChatMessage(
                      id: '__welcome__',
                      origin: MessageOrigin.llm,
                      text: viewModel.welcomeMessage,
                      attachments: [],
                    ),
                  ...history,
                  if (showStatusMessage)
                    ChatMessage(
                      id: '__status__',
                      origin: MessageOrigin.llm,
                      text: null,
                      attachments: [],
                    ),
                ];

                // if empty and the empty builder is provided
                if (source.isEmpty && widget.emptyBuilder != null) {
                  return widget.emptyBuilder!(context);
                }

                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(
                    context,
                  ).copyWith(scrollbars: false),
                  child: ListView.builder(
                    reverse: true,
                    padding: viewModel.style?.chatViewPadding,
                    itemCount: source.length + (showSuggestions ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (showSuggestions) {
                        index -= showWelcomeMessage ? 1 : 0;
                        if (index ==
                            source.length - (showWelcomeMessage ? 2 : 0)) {
                          return ChatSuggestionsView(
                            suggestions: viewModel.suggestions,
                            onSelectSuggestion: widget.onSelectSuggestion,
                          );
                        }
                      }
                      final messageIndex = source.length - index - 1;
                      final message = source[messageIndex];
                      final isLastUserMessage =
                          message.origin.isUser &&
                          messageIndex >= source.length - 2;
                      final canEdit =
                          isLastUserMessage && widget.onEditMessage != null;
                      final isUser = message.origin.isUser;

                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child:
                            isUser
                                ? UserMessageView(
                                  message,
                                  onEdit:
                                      canEdit
                                          ? () => widget.onEditMessage?.call(
                                            message,
                                          )
                                          : null,
                                )
                                : LlmMessageView(
                                  message,
                                  isWelcomeMessage: messageIndex == 0,
                                ),
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    ),
  );
}
