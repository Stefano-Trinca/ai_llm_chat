// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import '../styles/styles.dart';
import '../styles/toolkit_colors.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

/// Style for the entire chat widget.
@immutable
class LlmChatViewStyle {
  /// Creates a style object for the chat widget.
  const LlmChatViewStyle({
    this.backgroundColor,
    this.menuColor,
    this.maxWidth,
    this.chatViewPadding,
    this.progressIndicatorColor,
    this.userMessageStyle,
    this.llmMessageStyle,
    this.markdownBuilder,
    this.chatInputStyle,
    this.addButtonStyle,
    this.attachFileButtonStyle,
    this.cameraButtonStyle,
    this.stopButtonStyle,
    this.closeButtonStyle,
    this.cancelButtonStyle,
    this.copyButtonStyle,
    this.editButtonStyle,
    this.galleryButtonStyle,
    this.recordButtonStyle,
    this.submitButtonStyle,
    this.disabledButtonStyle,
    this.closeMenuButtonStyle,
    this.actionButtonBarDecoration,
    this.fileAttachmentStyle,
    this.suggestionStyle,
  });

  /// Resolves the provided [style] with the [defaultStyle].
  ///
  /// This method returns a new [LlmChatViewStyle] instance where each property
  /// is taken from the provided [style] if it is not null, otherwise from the
  /// [defaultStyle].
  ///
  /// - [style]: The style to resolve. If null, the [defaultStyle] will be used.
  /// - [defaultStyle]: The default style to use for any properties not provided
  ///   by the [style].
  factory LlmChatViewStyle.resolve(
    LlmChatViewStyle? style, {
    LlmChatViewStyle? defaultStyle,
  }) {
    defaultStyle ??= LlmChatViewStyle.defaultStyle();
    return LlmChatViewStyle(
      backgroundColor: style?.backgroundColor ?? defaultStyle.backgroundColor,
      menuColor: style?.menuColor ?? defaultStyle.menuColor,
      maxWidth: style?.maxWidth ?? defaultStyle.maxWidth,
      chatViewPadding: style?.chatViewPadding ?? defaultStyle.chatViewPadding,
      progressIndicatorColor:
          style?.progressIndicatorColor ?? defaultStyle.progressIndicatorColor,
      userMessageStyle: MessageStyle.resolve(
        style?.userMessageStyle,
        defaultStyle: defaultStyle.userMessageStyle,
      ),
      llmMessageStyle: MessageStyle.resolve(
        style?.llmMessageStyle,
        defaultStyle: defaultStyle.llmMessageStyle,
      ),
      markdownBuilder: style?.markdownBuilder ?? defaultStyle.markdownBuilder,
      chatInputStyle: ChatInputStyle.resolve(
        style?.chatInputStyle,
        defaultStyle: defaultStyle.chatInputStyle,
      ),
      addButtonStyle: ActionButtonStyle.resolve(
        style?.addButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(ActionButtonType.add),
      ),
      attachFileButtonStyle: ActionButtonStyle.resolve(
        style?.attachFileButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(
          ActionButtonType.attachFile,
        ),
      ),
      cameraButtonStyle: ActionButtonStyle.resolve(
        style?.cameraButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(ActionButtonType.camera),
      ),
      stopButtonStyle: ActionButtonStyle.resolve(
        style?.stopButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(ActionButtonType.stop),
      ),
      closeButtonStyle: ActionButtonStyle.resolve(
        style?.closeButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(ActionButtonType.close),
      ),
      cancelButtonStyle: ActionButtonStyle.resolve(
        style?.cancelButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(ActionButtonType.cancel),
      ),
      copyButtonStyle: ActionButtonStyle.resolve(
        style?.copyButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(ActionButtonType.copy),
      ),
      editButtonStyle: ActionButtonStyle.resolve(
        style?.editButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(ActionButtonType.edit),
      ),
      galleryButtonStyle: ActionButtonStyle.resolve(
        style?.galleryButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(ActionButtonType.gallery),
      ),
      recordButtonStyle: ActionButtonStyle.resolve(
        style?.recordButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(ActionButtonType.record),
      ),
      submitButtonStyle: ActionButtonStyle.resolve(
        style?.submitButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(ActionButtonType.submit),
      ),
      disabledButtonStyle: ActionButtonStyle.resolve(
        style?.disabledButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(ActionButtonType.disabled),
      ),
      closeMenuButtonStyle: ActionButtonStyle.resolve(
        style?.closeMenuButtonStyle,
        defaultStyle: ActionButtonStyle.defaultStyle(
          ActionButtonType.closeMenu,
        ),
      ),
      actionButtonBarDecoration:
          style?.actionButtonBarDecoration ??
          defaultStyle.actionButtonBarDecoration,
      suggestionStyle: SuggestionStyle.resolve(
        style?.suggestionStyle,
        defaultStyle: defaultStyle.suggestionStyle,
      ),
    );
  }

  /// Provides default style if none is specified.
  factory LlmChatViewStyle.defaultStyle() => LlmChatViewStyle._lightStyle();

  /// Provides a default light style.
  factory LlmChatViewStyle._lightStyle() => LlmChatViewStyle(
    backgroundColor: ToolkitColors.containerBackground,
    menuColor: ToolkitColors.containerBackground,
    maxWidth: _defaultMaxWidth,
    chatViewPadding: _defaultChatViewPadding,
    progressIndicatorColor: ToolkitColors.black,
    userMessageStyle: MessageStyle.defaultUser(),
    llmMessageStyle: MessageStyle.defaultLLM(),

    chatInputStyle: ChatInputStyle.defaultStyle(),
    addButtonStyle: ActionButtonStyle.defaultStyle(ActionButtonType.add),
    stopButtonStyle: ActionButtonStyle.defaultStyle(ActionButtonType.stop),
    recordButtonStyle: ActionButtonStyle.defaultStyle(ActionButtonType.record),
    submitButtonStyle: ActionButtonStyle.defaultStyle(ActionButtonType.submit),
    closeMenuButtonStyle: ActionButtonStyle.defaultStyle(
      ActionButtonType.closeMenu,
    ),
    attachFileButtonStyle: ActionButtonStyle.defaultStyle(
      ActionButtonType.attachFile,
    ),
    galleryButtonStyle: ActionButtonStyle.defaultStyle(
      ActionButtonType.gallery,
    ),
    cameraButtonStyle: ActionButtonStyle.defaultStyle(ActionButtonType.camera),
    closeButtonStyle: ActionButtonStyle.defaultStyle(ActionButtonType.close),
    cancelButtonStyle: ActionButtonStyle.defaultStyle(ActionButtonType.cancel),
    copyButtonStyle: ActionButtonStyle.defaultStyle(ActionButtonType.copy),
    editButtonStyle: ActionButtonStyle.defaultStyle(ActionButtonType.edit),
    actionButtonBarDecoration: BoxDecoration(
      color: null,
      borderRadius: BorderRadius.circular(20),
    ),
    fileAttachmentStyle: FileAttachmentStyle.defaultStyle(),
    suggestionStyle: SuggestionStyle.defaultStyle(),
  );

  /// Provides a from context theme style.
  factory LlmChatViewStyle.context(BuildContext context) => LlmChatViewStyle(
    backgroundColor: Theme.of(context).colorScheme.surface,
    menuColor: Theme.of(context).colorScheme.surfaceContainerHigh,
    maxWidth: _defaultMaxWidth,
    chatViewPadding: _defaultChatViewPadding,
    progressIndicatorColor: Theme.of(context).colorScheme.onSurfaceVariant,
    userMessageStyle: MessageStyle.contextUser(context),
    llmMessageStyle: MessageStyle.contextLLM(context),
    chatInputStyle: ChatInputStyle.context(context),
    addButtonStyle: ActionButtonStyle.context(context, ActionButtonType.add),
    stopButtonStyle: ActionButtonStyle.context(context, ActionButtonType.stop),
    recordButtonStyle: ActionButtonStyle.context(
      context,
      ActionButtonType.record,
    ),
    submitButtonStyle: ActionButtonStyle.context(
      context,
      ActionButtonType.submit,
    ),
    disabledButtonStyle: ActionButtonStyle.context(
      context,
      ActionButtonType.disabled,
    ),
    closeMenuButtonStyle: ActionButtonStyle.context(
      context,
      ActionButtonType.closeMenu,
    ),
    attachFileButtonStyle: ActionButtonStyle.context(
      context,
      ActionButtonType.attachFile,
    ),
    galleryButtonStyle: ActionButtonStyle.context(
      context,
      ActionButtonType.gallery,
    ),
    cameraButtonStyle: ActionButtonStyle.context(
      context,
      ActionButtonType.camera,
    ),
    closeButtonStyle: ActionButtonStyle.context(
      context,
      ActionButtonType.close,
    ),
    cancelButtonStyle: ActionButtonStyle.context(
      context,
      ActionButtonType.cancel,
    ),
    copyButtonStyle: ActionButtonStyle.context(context, ActionButtonType.copy),
    editButtonStyle: ActionButtonStyle.context(context, ActionButtonType.edit),
    actionButtonBarDecoration: BoxDecoration(
      color: null,
      borderRadius: BorderRadius.circular(20),
    ),
    fileAttachmentStyle: FileAttachmentStyle.defaultStyle(),
    suggestionStyle: SuggestionStyle.defaultStyle(),
  );

  /// Returns a copy of this style with the given fields replaced with the new values.
  LlmChatViewStyle copyWith({
    Color? backgroundColor,
    Color? menuColor,
    double? maxWidth,
    EdgeInsets? chatViewPadding,
    Color? progressIndicatorColor,
    MessageStyle? userMessageStyle,
    MessageStyle? llmMessageStyle,
    MarkdownBody Function(BuildContext context, String text)? markdownBuilder,
    ChatInputStyle? chatInputStyle,
    ActionButtonStyle? addButtonStyle,
    ActionButtonStyle? attachFileButtonStyle,
    ActionButtonStyle? cameraButtonStyle,
    ActionButtonStyle? stopButtonStyle,
    ActionButtonStyle? closeButtonStyle,
    ActionButtonStyle? cancelButtonStyle,
    ActionButtonStyle? copyButtonStyle,
    ActionButtonStyle? editButtonStyle,
    ActionButtonStyle? galleryButtonStyle,
    ActionButtonStyle? recordButtonStyle,
    ActionButtonStyle? submitButtonStyle,
    ActionButtonStyle? disabledButtonStyle,
    ActionButtonStyle? closeMenuButtonStyle,
    Decoration? actionButtonBarDecoration,
    FileAttachmentStyle? fileAttachmentStyle,
    SuggestionStyle? suggestionStyle,
  }) {
    return LlmChatViewStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      menuColor: menuColor ?? this.menuColor,
      maxWidth: maxWidth ?? this.maxWidth,
      markdownBuilder: markdownBuilder ?? this.markdownBuilder,
      chatViewPadding: chatViewPadding ?? this.chatViewPadding,
      progressIndicatorColor:
          progressIndicatorColor ?? this.progressIndicatorColor,
      userMessageStyle: userMessageStyle ?? this.userMessageStyle,
      llmMessageStyle: llmMessageStyle ?? this.llmMessageStyle,
      chatInputStyle: chatInputStyle ?? this.chatInputStyle,
      addButtonStyle: addButtonStyle ?? this.addButtonStyle,
      attachFileButtonStyle:
          attachFileButtonStyle ?? this.attachFileButtonStyle,
      cameraButtonStyle: cameraButtonStyle ?? this.cameraButtonStyle,
      stopButtonStyle: stopButtonStyle ?? this.stopButtonStyle,
      closeButtonStyle: closeButtonStyle ?? this.closeButtonStyle,
      cancelButtonStyle: cancelButtonStyle ?? this.cancelButtonStyle,
      copyButtonStyle: copyButtonStyle ?? this.copyButtonStyle,
      editButtonStyle: editButtonStyle ?? this.editButtonStyle,
      galleryButtonStyle: galleryButtonStyle ?? this.galleryButtonStyle,
      recordButtonStyle: recordButtonStyle ?? this.recordButtonStyle,
      submitButtonStyle: submitButtonStyle ?? this.submitButtonStyle,
      disabledButtonStyle: disabledButtonStyle ?? this.disabledButtonStyle,
      closeMenuButtonStyle: closeMenuButtonStyle ?? this.closeMenuButtonStyle,
      actionButtonBarDecoration:
          actionButtonBarDecoration ?? this.actionButtonBarDecoration,
      fileAttachmentStyle: fileAttachmentStyle ?? this.fileAttachmentStyle,
      suggestionStyle: suggestionStyle ?? this.suggestionStyle,
    );
  }

  /// Background color of the entire chat widget.
  final Color? backgroundColor;

  /// The color of the menu.
  final Color? menuColor;

  /// max width of the chat widget.
  ///
  /// default is 800.
  final double? maxWidth;

  static const double _defaultMaxWidth = 800;

  /// the padding of the chat view messages
  final EdgeInsets? chatViewPadding;

  static const EdgeInsets _defaultChatViewPadding = EdgeInsets.only(top: 120);

  /// The color of the progress indicator.
  final Color? progressIndicatorColor;

  /// Style for user messages.
  final MessageStyle? userMessageStyle;

  /// Style for LLM messages.
  final MessageStyle? llmMessageStyle;

  /// Builder for rendering Markdown text.
  final MarkdownBody Function(BuildContext context, String text)?
  markdownBuilder;

  /// Style for the input text box.
  final ChatInputStyle? chatInputStyle;

  /// Style for the add button.
  final ActionButtonStyle? addButtonStyle;

  /// Style for the attach file button.
  final ActionButtonStyle? attachFileButtonStyle;

  /// Style for the camera button.
  final ActionButtonStyle? cameraButtonStyle;

  /// Style for the stop button.
  final ActionButtonStyle? stopButtonStyle;

  /// Style for the close button.
  final ActionButtonStyle? closeButtonStyle;

  /// Style for the cancel button.
  final ActionButtonStyle? cancelButtonStyle;

  /// Style for the copy button.
  final ActionButtonStyle? copyButtonStyle;

  /// Style for the edit button.
  final ActionButtonStyle? editButtonStyle;

  /// Style for the gallery button.
  final ActionButtonStyle? galleryButtonStyle;

  /// Style for the record button.
  final ActionButtonStyle? recordButtonStyle;

  /// Style for the submit button.
  final ActionButtonStyle? submitButtonStyle;

  /// Style for the disabled button.
  final ActionButtonStyle? disabledButtonStyle;

  /// Style for the close menu button.
  final ActionButtonStyle? closeMenuButtonStyle;

  /// Decoration for the action button bar.
  final Decoration? actionButtonBarDecoration;

  /// Style for file attachments.
  final FileAttachmentStyle? fileAttachmentStyle;

  /// Style for suggestions.
  final SuggestionStyle? suggestionStyle;
}
