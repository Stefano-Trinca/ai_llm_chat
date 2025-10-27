// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';

import 'attachments.dart';
import 'chat_message.dart';

/// An abstract class representing a Language Model (LLM) provider.
///
/// This class defines the interface for interacting with different LLM
/// services. Implementations of this class should provide the logic for
/// generating text responses based on input prompts and optional attachments.
abstract class LlmProvider {
  /// Creates a new instance of [LlmProvider].
  ///
  ///  This constructor initializes the provider with an empty chat history.
  LlmProvider()
    : listenableHistory = ValueNotifier<List<ChatMessage>>(<ChatMessage>[]),
      listenableStatus = ValueNotifier<String>('idle'),
      listenableShowStatusMessage = ValueNotifier<bool>(false) {
    listenableHistory.addListener(_showStatusMessageListener);
    listenableStatus.addListener(_showStatusMessageListener);
  }

  /// A [ValueListenable] that provides access to the chat history.
  final ValueNotifier<List<ChatMessage>> listenableHistory;

  /// A [ValueNotifier] that provides access to the status of the LLM provider.
  final ValueNotifier<String> listenableStatus;

  /// A [ValueNotifier] that indicates whether to show a status message in the history
  final ValueNotifier<bool> listenableShowStatusMessage;

  /// This stream writes the generated text directly into the message widget
  /// with `status == streaming`.
  ///
  /// Generates a stream of text based on the provided [message].
  /// This method does not interact with a chat or use the message history.
  ///
  /// [message] represents the input [ChatMessage] for which to generate a response,
  /// and can include attachments such as images, files, or links to provide additional context.
  ///
  /// Returns a [Stream] of [String] containing the generated text fragments,
  /// allowing real-time display of the responses produced by the LLM
  /// directly in the message widget with streaming status.
  Stream<String> generateStream(ChatMessage message);

  /// Sends a message to the LLM provider with the given prompt and optional
  /// attachments.
  ///
  /// This method is used to send a message to the LLM provider, which can
  /// include a text prompt and optional attachments such as files or images.
  ///
  /// [prompt] is the text input to be sent to the LLM provider.
  /// [attachments] is an optional iterable of [Attachment] objects that can
  /// be included with the prompt. These attachments can be images, files, or
  /// links that provide additional context for the LLM.
  void onSendMessage(String prompt, Iterable<Attachment> attachments);

  // Sends an audio file to the LLM provider with optional attachments.
  ///
  /// This method is used to send an audio file for processing and get the text response
  ///
  /// [audioFile] is the audio file to be sent to the LLM provider.
  /// [attachments] is an optional iterable of [Attachment] objects that can
  /// be included with the audio file. These attachments can be images, files, or
  /// links that provide additional context for the LLM.
  void onSendAudio(XFile audioFile, Iterable<Attachment> attachments);

  /// Called when a suggestion is selected by the user.
  ///
  ///  This method is invoked when the user selects a suggestion from the
  ///  list of suggestions provided by the LLM provider. The [suggestion] parameter
  void onSelectSuggestion(String suggestion);

  /// Called when the user cancels a message.
  ///
  ///  This method is invoked when the user decides to cancel a message that
  ///  is currently being sent to the LLM provider. It allows the provider to
  ///  handle the cancellation appropriately, such as stopping any ongoing
  ///  processing or cleaning up resources related to the message.
  void onCancelMessage();

  /// Returns an iterable of [ChatMessage] objects representing the chat
  /// history.
  ///
  /// This getter provides access to the conversation history maintained by the
  /// LLM provider. The history typically includes both user messages and LLM
  /// responses in chronological order.
  ///
  /// Returns an [Iterable] of [ChatMessage] objects.
  List<ChatMessage> get history => listenableHistory.value;

  /// Returns the status of the LLM provider
  ///
  /// the status can be:
  /// - 'run' = is in running state and can not send messages
  /// - 'idle' = is in idle state and can send messages
  String get status => listenableStatus.value;

  /// Indicates whether the LLM provider is currently running.
  ///
  ///   This getter checks the current status of the LLM provider to determine
  ///   if it is in a running state. If the status is not 'idle'
  bool get isRunning => status != 'idle';

  /// Returns the status message of the LLM provider.
  ///
  /// this is used when the text of the message is null
  ///
  /// you can show a custom message based on the status of the provider,
  String get statusMessage;

  /// Sets the chat history to the provided messages.
  ///
  /// This setter allows updating the conversation history maintained by the LLM
  /// provider. The provided [history] replaces the existing history with a new
  /// set of messages.
  ///
  /// [history] is an [Iterable] of [ChatMessage] objects representing the new
  /// chat history.
  set history(List<ChatMessage> history) => listenableHistory.value = history;

  /// Sets the status of the LLM provider.
  ///
  ///  This setter allows updating the status of the LLM provider, which can
  ///  be used to indicate whether the provider is currently running, idle, or
  ///
  /// set to 'run' when the provider is busy processing a request and cannot
  ///  send messages, or 'idle' when it is ready to accept new requests.
  set status(String status) => listenableStatus.value = status;

  /// Updates the status message based on the current state of the history and
  /// the statusMessage that can be the stauts of the chat
  void _showStatusMessageListener() {
    final bool lastMessageUser =
        history.isNotEmpty && history.last.origin.isUser;
    final bool hasStatusMessage = statusMessage.isNotEmpty;
    final showStatusMessage = lastMessageUser && hasStatusMessage;
    if (listenableShowStatusMessage.value != showStatusMessage) {
      listenableShowStatusMessage.value = showStatusMessage;
    }
  }

  /// Disposes of the LLM provider resources.
  ///
  ///  This method is called to clean up resources used by the LLM provider,
  @mustCallSuper
  void dispose() {
    listenableHistory.dispose();
    listenableStatus.dispose();
    listenableShowStatusMessage.dispose();
  }
}

/// A function that generates a stream of text based on a prompt and
/// attachments.
typedef LlmStreamGenerator =
    Stream<String> Function(
      String prompt, {
      required Iterable<Attachment> attachments,
    });
