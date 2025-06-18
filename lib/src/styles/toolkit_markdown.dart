import 'package:flutter/material.dart';
import '../styles/toolkit_text_styles.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class ToolkitMarkdown {
  static MarkdownStyleSheet defaultMarkdownStyleSheet = MarkdownStyleSheet(
    a: ToolkitTextStyles.body1,
    blockquote: ToolkitTextStyles.body1,
    checkbox: ToolkitTextStyles.body1,
    code: ToolkitTextStyles.code,
    del: ToolkitTextStyles.body1,
    em: ToolkitTextStyles.body1.copyWith(fontStyle: FontStyle.italic),
    h1: ToolkitTextStyles.heading1,
    h2: ToolkitTextStyles.heading2,
    h3: ToolkitTextStyles.body1.copyWith(fontWeight: FontWeight.bold),
    h4: ToolkitTextStyles.body1,
    h5: ToolkitTextStyles.body1,
    h6: ToolkitTextStyles.body1,
    listBullet: ToolkitTextStyles.body1,
    img: ToolkitTextStyles.body1,
    strong: ToolkitTextStyles.body1.copyWith(fontWeight: FontWeight.bold),
    p: ToolkitTextStyles.body1,
    tableBody: ToolkitTextStyles.body1,
    tableHead: ToolkitTextStyles.body1,
  );

  static MarkdownStyleSheet ofContext(BuildContext context) =>
      MarkdownStyleSheet.fromTheme(Theme.of(context));
}
