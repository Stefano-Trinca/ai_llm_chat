// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'toolkit_colors.dart';
import 'toolkit_text_styles.dart';

/// Style for the input text box.
@immutable
class ChatInputStyle {
  /// Creates an InputBoxStyle.
  const ChatInputStyle({
    this.textStyle,
    this.hintStyle,
    this.advertisingMessageStyle,
    this.hintText,
    this.containerDecoration,
    this.fieldDecoration,
  });

  /// Merges the provided styles with the default styles.
  factory ChatInputStyle.resolve(
    ChatInputStyle? style, {
    ChatInputStyle? defaultStyle,
  }) {
    defaultStyle ??= ChatInputStyle.defaultStyle();
    return ChatInputStyle(
      textStyle: style?.textStyle ?? defaultStyle.textStyle,
      hintStyle: style?.hintStyle ?? defaultStyle.hintStyle,
      advertisingMessageStyle:
          style?.advertisingMessageStyle ??
          defaultStyle.advertisingMessageStyle,
      hintText: style?.hintText ?? defaultStyle.hintText,
      containerDecoration:
          style?.containerDecoration ?? defaultStyle.containerDecoration,
      fieldDecoration: style?.fieldDecoration ?? defaultStyle.fieldDecoration,
    );
  }

  /// Provides a default style.
  factory ChatInputStyle.defaultStyle() => ChatInputStyle._lightStyle();

  /// Provides a default light style.
  factory ChatInputStyle._lightStyle() => ChatInputStyle(
    textStyle: ToolkitTextStyles.body2,
    hintStyle: ToolkitTextStyles.body2.copyWith(color: ToolkitColors.hintText),
    advertisingMessageStyle: ToolkitTextStyles.label.copyWith(
      color: ToolkitColors.containerBackground,
      fontStyle: FontStyle.italic,
    ),
    hintText: 'Ask me anything...',
    containerDecoration: BoxDecoration(
      color: ToolkitColors.containerBackground,
    ),
    fieldDecoration: BoxDecoration(
      color: ToolkitColors.containerBackground,
      border: Border.all(width: 1, color: ToolkitColors.outline),
      borderRadius: BorderRadius.circular(24),
    ),
  );

  /// Provides a default light style.
  factory ChatInputStyle.context(BuildContext context) {
    final theme = Theme.of(context);
    return ChatInputStyle(
      textStyle: theme.textTheme.bodyMedium,
      hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
      advertisingMessageStyle: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
      hintText: 'Ask me anything...',
      containerDecoration: BoxDecoration(
        color:
            theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      fieldDecoration: BoxDecoration(
        color:
            theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surface,
        border: Border.all(width: 1, color: theme.dividerColor),
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  /// The text style for the input text box.
  final TextStyle? textStyle;

  /// The hint text style for the input text box.
  final TextStyle? hintStyle;

  /// The style for the advertising message, if any.
  final TextStyle? advertisingMessageStyle;

  /// The hint text for the input text box.
  final String? hintText;

  /// The decoration of the container that holds the input box
  final Decoration? containerDecoration;

  /// The decoration of the input box.
  final Decoration? fieldDecoration;

  /// Creates a copy of this [ChatInputStyle] but with the given fields replaced with the new values.
  ChatInputStyle copyWith({
    TextStyle? textStyle,
    TextStyle? hintStyle,
    TextStyle? advertisingMessageStyle,
    String? hintText,
    Decoration? containerDecoration,
    Decoration? fieldDecoration,
  }) {
    return ChatInputStyle(
      textStyle: textStyle ?? this.textStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      advertisingMessageStyle:
          advertisingMessageStyle ?? this.advertisingMessageStyle,
      hintText: hintText ?? this.hintText,
      containerDecoration: containerDecoration ?? this.containerDecoration,
      fieldDecoration: fieldDecoration ?? this.fieldDecoration,
    );
  }
}
