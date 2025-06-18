import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/src/styles/tookit_icons.dart';
import 'package:flutter_ai_toolkit/src/styles/toolkit_colors.dart';
import 'package:flutter_ai_toolkit/src/utils/theme_utils.dart';

/// A style class for customizing the appearance of avatar messages in a chat application.
@immutable
class AvatarMessageStyle {
  /// Creates an [AvatarMessageStyle].
  const AvatarMessageStyle({
    this.avatar,
    this.decoration,
    this.size,
    this.padding,
  });

  /// Creates an [AvatarMessageStyle] using values from the [BuildContext] if needed.
  factory AvatarMessageStyle.context(BuildContext context) {
    return AvatarMessageStyle(
      avatar: Center(
        child: Icon(
          ToolkitIcons.spark_icon,
          size: 20,
          color: context.colorScheme.primary,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colorScheme.surfaceContainerHigh,
      ),
      size: Size.square(24),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    );
  }

  /// Creates a default [AvatarMessageStyle].
  factory AvatarMessageStyle.defaultStyle() {
    return const AvatarMessageStyle(
      avatar: Center(
        child: Icon(
          ToolkitIcons.spark_icon,
          size: 20,
          color: ToolkitColors.whiteIcon,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ToolkitColors.llmIconBackground,
      ),
      size: Size.square(24),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    );
  }

  /// Returns a copy of this style with the given fields replaced with new values.
  AvatarMessageStyle copyWith({
    Widget? avatar,
    Decoration? decoration,
    Size? size,
    EdgeInsets? padding,
  }) {
    return AvatarMessageStyle(
      avatar: avatar ?? this.avatar,
      decoration: decoration ?? this.decoration,
      size: size ?? this.size,
      padding: padding ?? this.padding,
    );
  }

  /// the widget that will be used as avatar, default is a Icon widget
  final Widget? avatar;

  /// Decoration of the contianer that hold the avatar
  final Decoration? decoration;

  /// Size of the container that holds the avatar
  final Size? size;

  /// Padding around the avatar container
  final EdgeInsets? padding;

  /// Returns the total width of the avatar message, including padding.
  double get totalWidth => (size?.width ?? 0.0) + (padding?.horizontal ?? 0.0);
}
