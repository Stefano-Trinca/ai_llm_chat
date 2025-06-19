import 'package:ai_llm_chat/flutter_ai_toolkit.dart';
import 'package:ai_llm_chat_example/_sample_messages.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class TestLlmProvider extends LlmProvider {
  TestLlmProvider() {
    history = sampleMessages.toList();
  }

  @override
  Stream<String> generateStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) async* {
    status = 'run';
    await Future.delayed(const Duration(seconds: 1));
    String buffer = '';
    for (int i = 0; i < prompt.length; i++) {
      buffer += prompt[i];
      yield buffer;
      await Future.delayed(const Duration(milliseconds: 50));
    }
    status = 'idle';
  }

  void _setStreamMessage(
    String prompt,
    Iterable<Attachment> attachments,
    String messageId,
  ) {
    final index = history.indexWhere((m) => m.id == messageId);
    print('Setting stream message with id: $messageId and index: $index');

    generateStream(prompt, attachments: attachments).listen((event) {
      print('Received stream event: $event');
      // Find the message in _history with the same id
      if (index != -1) {
        // Append the new text to the existing message
        history[index].replace(event);
        history = history.toList();
      }
    });
  }

  @override
  void onSendMessage(String prompt, Iterable<Attachment> attachments) async {
    // set the user message
    final userMessage = ChatMessage(
      id: UniqueKey().toString(),
      origin: MessageOrigin.user,
      text: prompt,
      attachments: attachments,
    );

    final message = ChatMessage(
      id: UniqueKey().toString(),
      origin: MessageOrigin.llm,
      text: null,
      statusMessage: 'Sto cercando la risposta...',
      attachments: attachments,
    );

    final value = [...history, userMessage, message];
    history = value;
    _setStreamMessage(prompt, attachments, message.id);
  }

  @override
  void onCancelMessage() {
    // TODO: implement onCancelMessage
  }

  @override
  void onSelectSuggestion(String suggestion) {
    onSendMessage(suggestion, []);
  }
}
