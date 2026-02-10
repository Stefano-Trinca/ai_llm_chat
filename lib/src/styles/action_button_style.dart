// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'action_button_type.dart';
import 'tookit_icons.dart';
import 'toolkit_colors.dart';
import 'toolkit_text_styles.dart';

/// Style for icon buttons.
@immutable
class ActionButtonStyle {
  /// Creates an IconButtonStyle.
  const ActionButtonStyle({
    this.icon,
    this.iconColor,
    this.label,
    this.buttonStyle,
  });

  /// Resolves the provided [style] with the [defaultStyle].
  ///
  /// This method returns a new [ActionButtonStyle] instance where each property
  /// is taken from the provided [style] if it is not null, otherwise from the
  /// [defaultStyle].
  ///
  /// - [style]: The style to resolve. If null, the [defaultStyle] will be used.
  /// - [defaultStyle]: The default style to use for any properties not provided
  ///   by the [style].
  factory ActionButtonStyle.resolve(
    ActionButtonStyle? style, {
    required ActionButtonStyle defaultStyle,
  }) => ActionButtonStyle(
    icon: style?.icon ?? defaultStyle.icon,
    iconColor: style?.iconColor ?? defaultStyle.iconColor,
    label: style?.label ?? defaultStyle.label,
    buttonStyle: style?.buttonStyle ?? defaultStyle.buttonStyle,
  );

  /// Provides default style for icon buttons.
  factory ActionButtonStyle.defaultStyle(ActionButtonType type) =>
      ActionButtonStyle._lightStyle(type);

  /// Provides default light style for icon buttons.
  factory ActionButtonStyle._lightStyle(ActionButtonType type) {
    IconData icon;
    var color = ToolkitColors.darkIcon;
    var bgColor = ToolkitColors.lightButtonBackground;
    String text;
    TextStyle textStyle = ToolkitTextStyles.tooltip;

    switch (type) {
      case ActionButtonType.add:
        icon = ToolkitIcons.add;
        text = 'Add Attachment';
      case ActionButtonType.attachFile:
        icon = ToolkitIcons.attach_file;
        color = ToolkitColors.darkIcon;
        bgColor = ToolkitColors.transparent;
        text = 'Attach File';
        textStyle = ToolkitTextStyles.body2;
      case ActionButtonType.camera:
        icon = ToolkitIcons.camera_alt;
        color = ToolkitColors.darkIcon;
        bgColor = ToolkitColors.transparent;
        text = 'Take Photo';
        textStyle = ToolkitTextStyles.body2;
      case ActionButtonType.stop:
        icon = ToolkitIcons.stop;
        text = 'Stop';
      case ActionButtonType.close:
        icon = ToolkitIcons.close;
        color = ToolkitColors.whiteIcon;
        bgColor = ToolkitColors.darkButtonBackground;
        text = 'Close';
      case ActionButtonType.cancel:
        icon = ToolkitIcons.close;
        color = ToolkitColors.whiteIcon;
        bgColor = ToolkitColors.darkButtonBackground;
        text = 'Cancel';
      case ActionButtonType.copy:
        icon = ToolkitIcons.content_copy;
        color = ToolkitColors.whiteIcon;
        bgColor = ToolkitColors.darkButtonBackground;
        text = 'Copy to Clipboard';
      case ActionButtonType.edit:
        icon = ToolkitIcons.edit;
        color = ToolkitColors.whiteIcon;
        bgColor = ToolkitColors.darkButtonBackground;
        text = 'Edit Message';
      case ActionButtonType.gallery:
        icon = ToolkitIcons.image;
        color = ToolkitColors.darkIcon;
        bgColor = ToolkitColors.transparent;
        text = 'Attach Image';
        textStyle = ToolkitTextStyles.body2;
      case ActionButtonType.record:
        icon = ToolkitIcons.mic;
        text = 'Record Audio';
      case ActionButtonType.submit:
        icon = ToolkitIcons.submit_icon;
        color = ToolkitColors.whiteIcon;
        bgColor = ToolkitColors.darkButtonBackground;
        text = 'Submit Message';
      case ActionButtonType.disabled:
        icon = ToolkitIcons.submit_icon;
        color = ToolkitColors.darkIcon;
        bgColor = ToolkitColors.disabledButton;
        text = '';
      case ActionButtonType.closeMenu:
        icon = ToolkitIcons.close;
        color = ToolkitColors.whiteIcon;
        bgColor = ToolkitColors.greyBackground;
        text = 'Close Menu';
    }

    return ActionButtonStyle(icon: icon, iconColor: color, label: text);
  }

  /// Provides a style for icon buttons using the current Theme.
  factory ActionButtonStyle.context(
    BuildContext context,
    ActionButtonType type,
  ) {
    final theme = Theme.of(context);
    IconData icon;
    Color color = theme.iconTheme.color ?? theme.colorScheme.onSurface;
    String tooltip;
    ButtonStyle buttonStyle = IconButton.styleFrom();
    switch (type) {
      case ActionButtonType.add:
        icon = ToolkitIcons.add;
        tooltip = 'Add Attachment';
        break;
      case ActionButtonType.attachFile:
        icon = ToolkitIcons.attach_file;
        tooltip = 'Attach File';
        break;
      case ActionButtonType.camera:
        icon = ToolkitIcons.camera_alt;
        tooltip = 'Take Photo';
        break;
      case ActionButtonType.stop:
        icon = ToolkitIcons.stop;
        tooltip = 'Stop';
        break;
      case ActionButtonType.close:
        icon = ToolkitIcons.close;
        color = theme.colorScheme.onPrimary;
        buttonStyle = buttonStyle.copyWith(
          backgroundColor: WidgetStateProperty.all(theme.colorScheme.primary),
        );
        tooltip = 'Close';
        break;
      case ActionButtonType.cancel:
        icon = ToolkitIcons.close;
        tooltip = 'Cancel';
        break;
      case ActionButtonType.copy:
        icon = Icons.copy;
        tooltip = 'Copy to Clipboard';
        break;
      case ActionButtonType.edit:
        icon = ToolkitIcons.edit;
        tooltip = 'Edit Message';
        break;
      case ActionButtonType.gallery:
        icon = ToolkitIcons.image;
        tooltip = 'Attach Image';
        break;
      case ActionButtonType.record:
        icon = ToolkitIcons.mic;
        tooltip = 'Record Audio';
        break;
      case ActionButtonType.submit:
        icon = ToolkitIcons.submit_icon;
        tooltip = 'Submit Message';
        break;
      case ActionButtonType.disabled:
        icon = ToolkitIcons.submit_icon;
        tooltip = '';
        break;
      case ActionButtonType.closeMenu:
        icon = ToolkitIcons.close;
        tooltip = 'Close Menu';
        break;
    }

    return ActionButtonStyle(icon: icon, iconColor: color, label: tooltip);
  }

  /// Returns a copy of this [ActionButtonStyle] with the given fields replaced by new values.
  ActionButtonStyle copyWith({
    IconData? icon,
    Color? iconColor,
    String? label,
    ButtonStyle? buttonStyle,
  }) {
    return ActionButtonStyle(
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      label: label ?? this.label,
      buttonStyle: buttonStyle ?? this.buttonStyle,
    );
  }

  /// The icon to display for the icon button.
  final IconData? icon;

  /// The color of the icon.
  final Color? iconColor;

  /// The tooltip for the icon button (could be menu item text or a tooltip).
  final String? label;

  /// IconButton Style
  ///
  /// use IconButton.styleFrom to create a ButtonStyle for IconButton
  final ButtonStyle? buttonStyle;
}
