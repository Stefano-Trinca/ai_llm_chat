import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:flutter_ai_toolkit_example/_sample_messages.dart';

class TestLlmProvider extends LlmProvider {
  final List<ChatMessage> _history = sampleMessages.toList();

  @override
  Stream<String> generateStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) async* {
    await Future.delayed(const Duration(seconds: 1));
    String buffer = '';
    for (int i = 0; i < prompt.length; i++) {
      buffer += prompt[i];
      yield buffer;
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  @override
  Stream<String> sendMessageStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) async* {
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
      attachments: attachments,
    );

    _history.addAll([userMessage, message]);

    // Log start of sendMessageStream
    await for (final chunk in generateStream(
      prompt,
      attachments: attachments,
    )) {
      // Update the message in _history with the same id
      final index = _history.indexWhere((m) => m.id == message.id);
      if (index != -1) {
        _history[index] = ChatMessage(
          id: message.id,
          origin: message.origin,
          text: chunk,
          attachments: message.attachments,
        );
        notifyListeners();
      }
      yield chunk;
    }

    // // After streaming, add the LLM reply to history
    // final llmReply = ChatMessage(
    //   origin: MessageOrigin.llm,
    //   text: 'Test reply to: $prompt',
    //   attachments: const [],
    // );
    // _history.add(llmReply);
    // notifyListeners();
  }

  @override
  Iterable<ChatMessage> get history => _history;

  @override
  set history(Iterable<ChatMessage> history) {
    print('TestLlmProvider.history > Setting new history');
    _history
      ..clear()
      ..addAll(history);
  }

  final List<VoidCallback> _listeners = [];

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }
}
