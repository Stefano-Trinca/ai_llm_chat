// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ai_toolkit/src/styles/toolkit_markdown.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'tookit_icons.dart';
import 'toolkit_colors.dart';
import 'toolkit_text_styles.dart';

/// Style for LLM messages.
@immutable
class LlmMessageStyle {
  /// Creates an LlmMessageStyle.
  const LlmMessageStyle({
    this.icon,
    this.iconColor,
    this.iconDecoration,
    this.decoration,
    this.markdownStyle,
  });

  /// Resolves the provided style with the default style.
  ///
  /// This method creates a new [LlmMessageStyle] by combining the provided
  /// [style] with the [defaultStyle]. If a property is not specified in the
  /// provided [style], it falls back to the corresponding property in the
  /// [defaultStyle].
  ///
  /// If [defaultStyle] is not provided, it uses [LlmMessageStyle.defaultStyle].
  ///
  /// Parameters:
  ///   - [style]: The custom style to apply. Can be null.
  ///   - [defaultStyle]: The default style to use as a fallback. If null, uses
  ///     [LlmMessageStyle.defaultStyle].
  ///
  /// Returns: A new [LlmMessageStyle] instance with resolved properties.
  factory LlmMessageStyle.resolve(
    LlmMessageStyle? style, {
    LlmMessageStyle? defaultStyle,
  }) {
    defaultStyle ??= LlmMessageStyle.defaultStyle();
    return LlmMessageStyle(
      icon: style?.icon ?? defaultStyle.icon,
      iconColor: style?.iconColor ?? defaultStyle.iconColor,
      iconDecoration: style?.iconDecoration ?? defaultStyle.iconDecoration,
      markdownStyle: style?.markdownStyle ?? defaultStyle.markdownStyle,
      decoration: style?.decoration ?? defaultStyle.decoration,
    );
  }

  /// Provides a default style.
  factory LlmMessageStyle.defaultStyle() => LlmMessageStyle._lightStyle();

  /// Provides a default light style.
  factory LlmMessageStyle._lightStyle() => LlmMessageStyle(
    icon: ToolkitIcons.spark_icon,
    iconColor: ToolkitColors.darkIcon,
    iconDecoration: const BoxDecoration(
      color: ToolkitColors.llmIconBackground,
      shape: BoxShape.circle,
    ),
    markdownStyle: ToolkitMarkdown.defaultMarkdownStyleSheet,
    decoration: BoxDecoration(
      color: ToolkitColors.llmMessageBackground,
      border: Border.all(color: ToolkitColors.llmMessageOutline),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.zero,
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
  );

  /// Provides a style based on the current theme context.
  factory LlmMessageStyle.context(BuildContext context) {
    final theme = Theme.of(context);
    return LlmMessageStyle(
      icon: ToolkitIcons.spark_icon,
      iconColor: theme.colorScheme.primary,
      iconDecoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        shape: BoxShape.circle,
      ),
      markdownStyle: ToolkitMarkdown.ofContext(context),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        // border: Border.all(color: theme.colorScheme.outline),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.zero,
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  /// The icon to display for the LLM messages.
  final IconData? icon;

  /// The color of the icon.
  final Color? iconColor;

  /// The decoration for the icon.
  final Decoration? iconDecoration;

  /// The decoration for LLM message bubbles.
  final Decoration? decoration;

  /// The markdown style sheet for LLM messages.
  final MarkdownStyleSheet? markdownStyle;

  /// Returns a copy of this LlmMessageStyle with the given fields replaced.
  LlmMessageStyle copyWith({
    IconData? icon,
    Color? iconColor,
    Decoration? iconDecoration,
    Decoration? decoration,
    MarkdownStyleSheet? markdownStyle,
  }) {
    return LlmMessageStyle(
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      iconDecoration: iconDecoration ?? this.iconDecoration,
      decoration: decoration ?? this.decoration,
      markdownStyle: markdownStyle ?? this.markdownStyle,
    );
  }
}
