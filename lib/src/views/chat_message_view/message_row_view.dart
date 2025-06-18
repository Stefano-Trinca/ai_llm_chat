import 'package:flutter/material.dart';
import '../../providers/interface/attachments.dart';
import '../attachment_view/attachment_view.dart';

/// Defines the alignment options for a chat message row.
///
/// [MessageAlign] can be used to specify whether a message should be aligned
/// to the left, right, or center within the chat interface.
/// Specifies the alignment of a chat message within a row.
///
/// The [MessageAlign] enum is used to determine how a message should be aligned
/// in the chat interface.
///
/// Values:
/// - [left]: Aligns the message to the left side.
/// - [right]: Aligns the message to the right side.
/// - [center]: Centers the message horizontally.
enum MessageAlign {
  /// Aligns the message to the left side.
  left,

  /// Aligns the message to the right side.
  right,

  /// Centers the message horizontally.
  center,
}

/// A widget that rappresents a single message row in a chat view.
/// This widget is typically used to display a message in a chat interface.
class MessageRowView extends StatelessWidget {
  /// Creates a [MessageRowView].
  ///
  const MessageRowView({
    super.key,
    this.messageFlex = const (6, 1),
    required this.align,
    this.avatar,
    required this.messageContainer,
    this.attachments,
  });

  /// The flex values for the message and space in the row.
  ///
  /// the first value represents the flex for the message,
  /// and the second value represents the flex for the space.
  ///
  /// defaults to (6, 1).
  final (int messageFlex, int spaceFlex) messageFlex;

  /// Specifies the alignment of the chat message within the row.
  ///
  /// Typically used to determine whether the message should be aligned
  /// to the left, right, or center, depending on the sender or message type.
  final MessageAlign align;

  /// The widget to display as the avatar in the message row.
  final Widget? avatar;

  /// The widget that contains the message content.
  final Widget messageContainer;

  /// The attachments associated with the message.
  final Iterable<Attachment>? attachments;

  @override
  Widget build(BuildContext context) {
    final container = Column(
      children: [
        if (attachments != null) ...[
          for (final attachment in attachments!)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: 80,
                  width: 200,
                  child: AttachmentView(attachment),
                ),
              ),
            ),
        ],
        messageContainer,
      ],
    );

    return switch (align) {
      /// Aligns the message to the left side of the row.
      MessageAlign.left => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (avatar != null) avatar!,
          Flexible(flex: messageFlex.$1, child: container),
          Flexible(flex: messageFlex.$2, child: const SizedBox()),
        ],
      ),

      /// Aligns the message to the right side of the row.
      MessageAlign.right => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(flex: messageFlex.$2, child: const SizedBox()),
          Flexible(flex: messageFlex.$1, child: container),
          if (avatar != null) avatar!,
        ],
      ),

      /// Centers the message horizontally within the row.
      MessageAlign.center => Center(child: container),
    };
  }
}
