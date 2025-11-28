import 'package:ai_llm_chat/flutter_ai_toolkit.dart';
import 'package:flutter/material.dart';

/// Represents an action that can be performed on a message, such as reply or delete.
class MessageAction {
  /// The text label for the action (e.g., "Reply", "Delete").
  final String label;

  /// The icon to display for the action.
  final IconData icon;

  /// The callback to execute when the action is pressed.
  final Function(ChatMessage message)? onPressed;

  /// Creates a [MessageAction] with the given [label], [icon], and [onPressed] callback.
  ///
  /// The [icon] parameter is required. The [label] defaults to an empty string if not provided.
  const MessageAction({this.label = '', required this.icon, this.onPressed});

  /// Creates a copy of this [MessageAction] with the given fields replaced by new values.
  MessageAction copyWith({
    String? label,
    IconData? icon,
    Function(ChatMessage message)? onPressed,
  }) {
    return MessageAction(
      label: label ?? this.label,
      icon: icon ?? this.icon,
      onPressed: onPressed ?? this.onPressed,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MessageAction) return false;
    return label == other.label &&
        icon == other.icon &&
        onPressed == other.onPressed;
  }

  @override
  int get hashCode => Object.hash(label, icon, onPressed);
}
