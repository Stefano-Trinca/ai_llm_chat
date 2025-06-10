import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

class TestLlmProvider extends LlmProvider {
  final List<ChatMessage> _history = [];

  @override
  Stream<String> generateStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) async* {
    print(
      'TestLlmProvider.generateStream > Generating stream for prompt: $prompt',
    );
    yield 'Test response for: $prompt';
  }

  @override
  Stream<String> sendMessageStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) async* {
    print('TestLlmProvider.sendMessageStream > Sending message: $prompt');
    _history.add(
      ChatMessage(
        origin: MessageOrigin.user,
        text: prompt,
        attachments: attachments,
      ),
    );
    yield 'Test reply to: $prompt';
    _history.add(
      ChatMessage(
        origin: MessageOrigin.llm,
        text: 'Test reply to: $prompt',
        attachments: const [],
      ),
    );
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
