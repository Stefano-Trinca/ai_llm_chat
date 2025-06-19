// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// using dynamic calls to translate to/from JSON
// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import '../../providers/interface/attachments.dart';
import 'message_origin.dart';

/// Represents a message in a chat conversation.
///
/// This class encapsulates the properties and behavior of a chat message,
/// including its unique identifier, origin (user or LLM), text content,
/// and any attachments.
class ChatMessage {
  /// Constructs a [ChatMessage] instance.
  ///
  /// The [origin] parameter specifies the origin of the message (user or LLM).
  /// The [text] parameter is the content of the message. It can be null or
  /// empty if the message is from an LLM. For user-originated messages, [text]
  /// must not be null or empty. The [attachments] parameter is a list of any
  /// files or media attached to the message.
  ChatMessage({
    required this.id,
    required this.origin,
    required this.text,
    this.status = '',
    this.statusMessage,
    required this.attachments,
  }) : assert(origin.isUser && text != null && text.isNotEmpty || origin.isLlm);

  /// Converts a JSON map representation to a [ChatMessage].
  ///
  /// The map should contain the following keys:
  /// - 'origin': The origin of the message (user or model).
  /// - 'text': The text content of the message.
  /// - 'attachments': A list of attachments, each represented as a map with:
  ///   - 'type': The type of the attachment ('file' or 'link').
  ///   - 'name': The name of the attachment.
  ///   - 'mimeType': The MIME type of the attachment.
  ///   - 'data': The data of the attachment, either as a base64 encoded string
  ///     (for files) or a URL (for links).
  factory ChatMessage.fromJson(Map<String, dynamic> map) => ChatMessage(
    id: map['id'] as String,
    origin: MessageOrigin.values.byName(map['origin'] as String),
    text: map['text'] as String,
    status: map['status'] as String? ?? '',
    statusMessage: map['statusMessage'] as String?,
    attachments: [
      for (final attachment in map['attachments'] as List<dynamic>)
        switch (attachment['type'] as String) {
          'file' => FileAttachment.fileOrImage(
            name: attachment['name'] as String,
            mimeType: attachment['mimeType'] as String,
            bytes: base64Decode(attachment['data'] as String),
          ),
          'link' => LinkAttachment(
            name: attachment['name'] as String,
            url: Uri.parse(attachment['data'] as String),
          ),
          _ => throw UnimplementedError(),
        },
    ],
  );

  /// Factory constructor for creating an LLM-originated message.
  ///
  /// Creates a message with an empty text content and no attachments.
  factory ChatMessage.llm({required String id}) => ChatMessage(
    id: id,
    origin: MessageOrigin.llm,
    text: null,
    status: '',
    statusMessage: null,
    attachments: [],
  );

  /// Factory constructor for creating a user-originated message.
  ///
  /// [text] is the content of the user's message.
  /// [attachments] are any files or media the user has attached to the message.
  factory ChatMessage.user(
    String id,
    String text,
    Iterable<Attachment> attachments,
  ) => ChatMessage(
    id: id,
    origin: MessageOrigin.user,
    text: text,
    status: '',
    statusMessage: null,
    attachments: attachments,
  );

  /// Unique identifier for the message.
  final String id;

  /// Text content of the message.
  String? text;

  /// The origin of the message (user or LLM).
  final MessageOrigin origin;

  /// the status of the message, that can be te

  /// Any attachments associated with the message.
  final Iterable<Attachment> attachments;

  /// the status of the message
  ///
  /// when the status is 'streaming' the text will be get from the stream of the provider
  final String status;

  /// the status message of the message, that can be used to display when the text is null
  String? statusMessage;

  /// Appends additional text to the existing message content.
  ///
  /// This is typically used for LLM messages that are streamed in parts.
  void append(String text) => this.text = (this.text ?? '') + text;

  /// Replace the currente text with the provided text.
  void replace(String text) => this.text = text;

  /// Replace the current status message with the provided text.
  ///
  /// if null the status message will be removed.
  void replaceStatusMessage(String? text) => statusMessage = text;

  /// Returns a copy of this [ChatMessage] with the given fields replaced.
  ChatMessage copyWith({
    String? id,
    MessageOrigin? origin,
    String? text,
    String? status,
    String? statusMessage,
    Iterable<Attachment>? attachments,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      origin: origin ?? this.origin,
      text: text ?? this.text,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      attachments: attachments ?? this.attachments,
    );
  }

  @override
  String toString() =>
      'ChatMessage('
      'id: $id, '
      'origin: $origin, '
      'text: $text, '
      'status: $status, '
      'statusMessage: $statusMessage, '
      'attachments: $attachments'
      ')';

  /// Converts a [ChatMessage] to a JSON map representation.
  ///
  /// The map contains the following keys:
  /// - 'origin': The origin of the message (user or model).
  /// - 'text': The text content of the message.
  /// - 'attachments': A list of attachments, each represented as a map with:
  ///   - 'type': The type of the attachment ('file' or 'link').
  ///   - 'name': The name of the attachment.
  ///   - 'mimeType': The MIME type of the attachment.
  ///   - 'data': The data of the attachment, either as a base64 encoded string
  ///     (for files) or a URL (for links).
  Map<String, dynamic> toJson() => {
    'id': id,
    'origin': origin.name,
    'text': text,
    'status': status,
    'statusMessage': statusMessage,
    'attachments': [
      for (final attachment in attachments)
        {
          'type': switch (attachment) {
            (FileAttachment _) => 'file',
            (LinkAttachment _) => 'link',
          },
          'name': attachment.name,
          'mimeType': switch (attachment) {
            (final FileAttachment a) => a.mimeType,
            (final LinkAttachment a) => a.mimeType,
          },
          'data': switch (attachment) {
            (final FileAttachment a) => base64Encode(a.bytes),
            (final LinkAttachment a) => a.url,
          },
        },
    ],
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatMessage) return false;
    return id == other.id &&
        origin == other.origin &&
        text == other.text &&
        status == other.status &&
        statusMessage == other.statusMessage &&
        _attachmentsEqual(attachments, other.attachments);
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      origin,
      text,
      status,
      statusMessage,
      Object.hashAll(attachments),
    );
  }

  bool _attachmentsEqual(Iterable<Attachment> a, Iterable<Attachment> b) {
    final aList = a.toList();
    final bList = b.toList();
    if (aList.length != bList.length) return false;
    for (int i = 0; i < aList.length; i++) {
      if (aList[i] != bList[i]) return false;
    }
    return true;
  }
}
