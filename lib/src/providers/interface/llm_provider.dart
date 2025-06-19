// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
      listenableStatus = ValueNotifier<String>('idle');

  /// A [ValueListenable] that provides access to the chat history.
  final ValueNotifier<List<ChatMessage>> listenableHistory;

  /// A [ValueNotifier] that provides access to the status of the LLM provider.
  final ValueNotifier<String> listenableStatus;

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
  ///  This getter checks the status of the LLM provider and returns true if
  ///  the status is 'run', indicating that the provider is currently busy
  bool get isRunning => status == 'run';

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
}

/// A function that generates a stream of text based on a prompt and
/// attachments.
typedef LlmStreamGenerator =
    Stream<String> Function(
      String prompt, {
      required Iterable<Attachment> attachments,
    });
