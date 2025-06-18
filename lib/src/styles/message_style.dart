// filepath: c:\Users\stman\AndroidStudioProjects\MINDELVE\LIBRARY\ai_llm_chat\lib\src\styles\message_style.dart
// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import '../styles/avatar_message_style.dart';
import '../styles/toolkit_markdown.dart';
import '../styles/toolkit_text_styles.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'toolkit_colors.dart';

/// Style for generic messages.
@immutable
class MessageStyle {
  /// Creates a MessageStyle.
  const MessageStyle({
    this.showAvatar = true,
    this.avatarStyle,
    this.decoration,
    this.markdownStyle,
    this.padding,
    this.textStyle,
    this.statusMessageStyle,
    this.statusMessageShimmerColors,
  });

  /// Resolves the provided style with the default style.
  factory MessageStyle.resolve(
    MessageStyle? style, {
    MessageStyle? defaultStyle,
  }) {
    defaultStyle ??= MessageStyle.defaultUser();
    return MessageStyle(
      showAvatar: style?.showAvatar ?? defaultStyle.showAvatar,
      avatarStyle: style?.avatarStyle ?? defaultStyle.avatarStyle,
      decoration: style?.decoration ?? defaultStyle.decoration,
      markdownStyle: style?.markdownStyle ?? defaultStyle.markdownStyle,
      padding: style?.padding ?? defaultStyle.padding ?? _defaultPaddingLLM,
      textStyle: style?.textStyle ?? defaultStyle.textStyle,
      statusMessageStyle:
          style?.statusMessageStyle ?? defaultStyle.statusMessageStyle,
      statusMessageShimmerColors:
          style?.statusMessageShimmerColors ??
          defaultStyle.statusMessageShimmerColors,
    );
  }

  /// Provides a default style for the User message
  factory MessageStyle.defaultUser() => MessageStyle(
    showAvatar: false,
    avatarStyle: AvatarMessageStyle.defaultStyle(),
    decoration: BoxDecoration(
      color: ToolkitColors.userMessageBackground,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.zero,
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    markdownStyle: ToolkitMarkdown.defaultMarkdownStyleSheet,
    padding: _defaultPaddingUser,
    textStyle: ToolkitTextStyles.body1,
    statusMessageStyle: ToolkitTextStyles.body1,
    statusMessageShimmerColors: (Colors.grey, Colors.white),
  );

  /// Provides a default style for the User message
  factory MessageStyle.defaultLLM() => MessageStyle(
    showAvatar: true,
    avatarStyle: AvatarMessageStyle.defaultStyle(),
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
    markdownStyle: ToolkitMarkdown.defaultMarkdownStyleSheet,
    padding: _defaultPaddingLLM,
    textStyle: ToolkitTextStyles.body1,
    statusMessageStyle: ToolkitTextStyles.body1,
    statusMessageShimmerColors: (Colors.grey, Colors.white),
  );

  /// Provides a style user based on the current theme context.
  factory MessageStyle.contextUser(BuildContext context) {
    final theme = Theme.of(context);
    return MessageStyle(
      showAvatar: false,
      avatarStyle: AvatarMessageStyle.context(context),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        // border: Border.all(color: theme.colorScheme.outline),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.zero,
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      markdownStyle: ToolkitMarkdown.ofContext(context),
      padding: _defaultPaddingUser,
      textStyle: theme.textTheme.bodyMedium,
      statusMessageStyle: theme.textTheme.bodyMedium,
      statusMessageShimmerColors: (
        theme.colorScheme.onSurfaceVariant.withAlpha(120),
        theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  /// Provides a style user based on the current theme context.
  factory MessageStyle.contextLLM(BuildContext context) {
    final theme = Theme.of(context);
    return MessageStyle(
      showAvatar: true,
      avatarStyle: AvatarMessageStyle.context(context),
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
      markdownStyle: ToolkitMarkdown.ofContext(context),
      padding: _defaultPaddingLLM,
      textStyle: theme.textTheme.bodyMedium,
      statusMessageStyle: theme.textTheme.bodyMedium,
      statusMessageShimmerColors: (
        theme.colorScheme.onSurfaceVariant.withAlpha(120),
        theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  /// show the avatar for the message.
  final bool showAvatar;

  /// Style of the avatar for the message.
  final AvatarMessageStyle? avatarStyle;

  /// The decoration for message bubbles.
  final BoxDecoration? decoration;

  /// The markdown style sheet for messages.
  final MarkdownStyleSheet? markdownStyle;

  /// the internal padding for the message.
  final EdgeInsets? padding;

  /// The text style for the message content.
  final TextStyle? textStyle;

  /// The text style for status messages.
  final TextStyle? statusMessageStyle;

  /// The shimmer colors for status messages.
  final (Color baseColor, Color hilightColor)? statusMessageShimmerColors;

  static const EdgeInsets _defaultPaddingLLM = EdgeInsets.all(8);
  static const EdgeInsets _defaultPaddingUser = EdgeInsets.all(16);

  /// Returns a copy of this MessageStyle with the given fields replaced.
  MessageStyle copyWith({
    bool? showAvatar,
    AvatarMessageStyle? avatarStyle,
    BoxDecoration? decoration,
    MarkdownStyleSheet? markdownStyle,
    EdgeInsets? padding,
    TextStyle? textStyle,
    TextStyle? statusMessageStyle,
    (Color baseColor, Color hilightColor)? statusMessageShimmerColors,
  }) {
    return MessageStyle(
      showAvatar: showAvatar ?? this.showAvatar,
      avatarStyle: avatarStyle ?? this.avatarStyle,
      decoration: decoration ?? this.decoration,
      markdownStyle: markdownStyle ?? this.markdownStyle,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      statusMessageStyle: statusMessageStyle ?? this.statusMessageStyle,
      statusMessageShimmerColors:
          statusMessageShimmerColors ?? this.statusMessageShimmerColors,
    );
  }
}
