// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'toolkit_colors.dart';
import 'toolkit_text_styles.dart';

/// Style for the input text box.
@immutable
class ChatInputStyle {
  /// Creates an InputBoxStyle.
  const ChatInputStyle({
    this.textStyle,
    this.hintStyle,
    this.hintText,
    this.backgroundColor,
    this.decoration,
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
      hintText: style?.hintText ?? defaultStyle.hintText,
      backgroundColor: style?.backgroundColor ?? defaultStyle.backgroundColor,
      decoration: style?.decoration ?? defaultStyle.decoration,
    );
  }

  /// Provides a default style.
  factory ChatInputStyle.defaultStyle() => ChatInputStyle._lightStyle();

  /// Provides a default light style.
  factory ChatInputStyle._lightStyle() => ChatInputStyle(
    textStyle: ToolkitTextStyles.body2,
    hintStyle: ToolkitTextStyles.body2.copyWith(color: ToolkitColors.hintText),
    hintText: 'Ask me anything...',
    backgroundColor: ToolkitColors.containerBackground,
    decoration: BoxDecoration(
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
      hintText: 'Ask me anything...',
      backgroundColor:
          theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surface,
      decoration: BoxDecoration(
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

  /// The hint text for the input text box.
  final String? hintText;

  /// The background color of the input box.
  final Color? backgroundColor;

  /// The decoration of the input box.
  final Decoration? decoration;
}
