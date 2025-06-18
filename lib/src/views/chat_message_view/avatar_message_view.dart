import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/src/styles/avatar_message_style.dart';

/// A widget that displays an avatar for the message view
@immutable
class AvatarMessageView extends StatelessWidget {
  /// Creates an [AvatarMessageView].
  ///
  /// The [style] parameter is required and represents the style
  /// to be applied to the avatar message view.
  const AvatarMessageView({super.key, this.style});

  /// The style to be applied to the avatar message view.
  final AvatarMessageStyle? style;

  @override
  Widget build(BuildContext context) {
    final stl = style ?? AvatarMessageStyle.context(context);

    return Padding(
      padding: stl.padding ?? EdgeInsets.zero,
      child: SizedBox(
        width: stl.size?.width ?? 24,
        height: stl.size?.height ?? 24,
        child: Container(decoration: stl.decoration, child: stl.avatar),
      ),
    );
  }
}
