import 'package:ai_llm_chat/flutter_ai_toolkit.dart';
import 'package:flutter/material.dart';

class TestLlmProvider extends LlmProvider {
  // final List<ChatMessage> _history = sampleMessages.toList();
  final List<ChatMessage> _history = [];

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
      statusMessage: 'Sto cercando la risposta...',
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
        _history[index].replace(chunk);
        notifyListeners();
      }
      yield chunk;
    }
  }

  @override
  Iterable<ChatMessage> get history => _history;

  @override
  set history(Iterable<ChatMessage> history) {
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
