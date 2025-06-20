import 'package:ai_llm_chat/flutter_ai_toolkit.dart';
import 'package:ai_llm_chat_example/_sample_messages.dart';
import 'package:flutter/material.dart';

class TestLlmProvider extends LlmProvider {
  TestLlmProvider() {
    history = sampleMessages.toList();
  }

  String _tempText = '';

  @override
  Stream<String> generateStream(ChatMessage message) async* {
    await Future.delayed(const Duration(seconds: 1));
    status = 'writing';
    String buffer = '';
    for (int i = 0; i < _tempText.length; i++) {
      buffer += _tempText[i];
      yield buffer;
      await Future.delayed(const Duration(milliseconds: 50));
    }

    final idx = history.indexWhere((e) => e.id == message.id);
    if (idx != -1) {
      final llmMessage = history[idx].copyWith(text: _tempText, status: '');
      final _source = history.toList();
      _source[idx] = llmMessage;
      history = _source;
    }
    status = 'idle';
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

    final value = [...history, userMessage];
    history = value;

    status = 'thinking';
    await Future.delayed(const Duration(seconds: 2));

    final message = ChatMessage(
      id: UniqueKey().toString(),
      origin: MessageOrigin.llm,
      text: null,
      status: 'streaming',
      attachments: attachments,
    );

    final newValue = [...history, message];
    _tempText = prompt;
    history = newValue;
  }

  @override
  String get statusMessage {
    if (status == 'thinking') {
      return 'Thinking...';
    }
    return '...';
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
