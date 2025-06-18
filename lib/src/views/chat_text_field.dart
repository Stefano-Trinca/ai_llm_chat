import 'package:flutter/cupertino.dart' show CupertinoTextField;
import 'package:flutter/material.dart'
    show Colors, InputBorder, InputDecoration, TextField, TextInputAction;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../styles/toolkit_colors.dart';
import '../utility.dart';

/// A text field that adapts to the current app style (Material or Cupertino).
///
/// This widget will render either a [CupertinoTextField] or a [TextField]
/// depending on whether the app is using Cupertino or Material design.
@immutable
class ChatTextField extends StatefulWidget {
  /// Creates an adaptive text field.
  ///
  /// Many of the parameters are required to ensure consistent behavior
  /// across both Cupertino and Material designs.
  const ChatTextField({
    required this.minLines,
    required this.maxLines,
    required this.autofocus,
    required this.style,
    required this.textInputAction,
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    required this.hintText,
    required this.hintStyle,
    required this.hintPadding,
    super.key,
  });

  /// The minimum number of lines to show.
  final int minLines;

  /// The maximum number of lines to show.
  final int maxLines;

  /// Whether the text field should be focused initially.
  final bool autofocus;

  /// The style to use for the text being edited.
  final TextStyle style;

  /// The type of action button to use for the keyboard.
  final TextInputAction textInputAction;

  /// Controls the text being edited.
  final TextEditingController controller;

  /// Defines the keyboard focus for this widget.
  final FocusNode focusNode;

  /// The text to show when the text field is empty.
  final String hintText;

  /// The style to use for the hint text.
  final TextStyle hintStyle;

  /// The padding to use for the hint text.
  final EdgeInsetsGeometry? hintPadding;

  /// Called when the user submits editable content.
  final void Function(String text) onSubmitted;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _focusNode = widget.focusNode;
    _focusNode.onKeyEvent = _handleKeyEvent;
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
      if (HardwareKeyboard.instance.isShiftPressed) {
        // Inserisci newline
        final text = _controller.text;
        final pos = _controller.selection.baseOffset;
        _controller.text = text.replaceRange(pos, pos, '\n');
        _controller.selection = TextSelection.collapsed(offset: pos + 1);
      } else {
        _sendMessage();
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _sendMessage() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      widget.onSubmitted(text);
      // _controller.clear();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      isCupertinoApp(context)
          ? CupertinoTextField(
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            controller: _controller,
            autofocus: widget.autofocus,
            focusNode: widget.focusNode,
            // onSubmitted: onSubmitted,
            style: widget.style,
            placeholder: widget.hintText,
            placeholderStyle: widget.hintStyle,
            padding: widget.hintPadding ?? EdgeInsets.zero,
            decoration: BoxDecoration(
              border: Border.all(width: 0, color: ToolkitColors.transparent),
            ),
            textInputAction: widget.textInputAction,
          )
          : TextField(
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            controller: _controller,
            autofocus: widget.autofocus,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction,
            // onSubmitted: onSubmitted,
            style: widget.style,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              contentPadding: widget.hintPadding,
              isDense: false,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
          );
}
