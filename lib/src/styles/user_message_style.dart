// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ai_toolkit/src/styles/toolkit_markdown.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'toolkit_colors.dart';
import 'toolkit_text_styles.dart';

/// Style for user messages.
@immutable
class UserMessageStyle {
  /// Creates a UserMessageStyle.
  const UserMessageStyle({this.textStyle, this.decoration, this.markdownStyle});

  /// Resolves the UserMessageStyle by combining the provided style with default
  /// values.
  ///
  /// This method takes an optional [style] and merges it with the
  /// [defaultStyle]. If [defaultStyle] is not provided, it uses
  /// [UserMessageStyle.defaultStyle].
  ///
  /// [style] - The custom UserMessageStyle to apply. Can be null.
  /// [defaultStyle] - The default UserMessageStyle to use as a base. If null,
  /// uses [UserMessageStyle.defaultStyle].
  ///
  /// Returns a new [UserMessageStyle] instance with resolved properties.
  factory UserMessageStyle.resolve(
    UserMessageStyle? style, {
    UserMessageStyle? defaultStyle,
  }) {
    defaultStyle ??= UserMessageStyle.defaultStyle();
    return UserMessageStyle(
      textStyle: style?.textStyle ?? defaultStyle.textStyle,
      decoration: style?.decoration ?? defaultStyle.decoration,
      markdownStyle: style?.markdownStyle ?? defaultStyle.markdownStyle,
    );
  }

  /// Provides default style data for user messages.
  factory UserMessageStyle.defaultStyle() => UserMessageStyle._lightStyle();

  /// Provides a default light style.
  factory UserMessageStyle._lightStyle() => UserMessageStyle(
    textStyle: ToolkitTextStyles.body1,
    decoration: const BoxDecoration(
      color: ToolkitColors.userMessageBackground,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.zero,
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    markdownStyle: ToolkitMarkdown.defaultMarkdownStyleSheet,
  );

  /// Provides a style based on the current theme context.
  factory UserMessageStyle.context(BuildContext context) {
    final theme = Theme.of(context);
    return UserMessageStyle(
      textStyle: theme.textTheme.bodyMedium,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.zero,
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      markdownStyle: ToolkitMarkdown.ofContext(context),
    );
  }

  /// The text style for user messages.
  final TextStyle? textStyle;

  /// The decoration for user message bubbles.
  final Decoration? decoration;

  /// The markdown style sheet for User messages.
  final MarkdownStyleSheet? markdownStyle;
}
