import 'package:ai_llm_chat/flutter_ai_toolkit.dart';
import 'package:ai_llm_chat_example/_sample_messages.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class TestLlmProvider extends LlmProvider {
  TestLlmProvider() {
    history = sampleMessages.toList();
  }

  String _tempText = '';

  @override
  Stream<String> generateStream(ChatMessage message) async* {
    status = 'run';
    await Future.delayed(const Duration(seconds: 1));
    String buffer = '';
    for (int i = 0; i < _tempText.length; i++) {
      buffer += _tempText[i];
      yield buffer;
      await Future.delayed(const Duration(milliseconds: 50));
    }

    if (history.isNotEmpty && history.last.status == 'streaming') {
      final llmMessage = history.last.copyWith(text: _tempText, status: '');
      final _source = history.toList();
      _source.last = llmMessage;
      _tempText = '';
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

    final message = ChatMessage(
      id: UniqueKey().toString(),
      origin: MessageOrigin.llm,
      text: null,
      statusMessage: 'Sto cercando la risposta...',
      status: 'streaming',
      attachments: attachments,
    );

    final value = [...history, userMessage, message];
    _tempText = prompt;
    history = value;
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
