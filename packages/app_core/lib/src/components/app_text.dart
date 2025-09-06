import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AppText extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final int maxLines;
  final bool isFit;
  final bool isSelectable;
  final bool markdown;
  final TextStyle? style;

  const AppText({
    super.key,
    this.text,
    this.textAlign,
    this.maxLines = 1,
    this.isFit = true,
    this.markdown = false,
    this.isSelectable = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) return const SizedBox();
    final textStyle = style ?? context.bodyMedium;
    final textWidget = markdown
        ? Markdown(
            data: text!.replaceAll("\\n", "\n"),
            selectable: true,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              textScaler: TextScaler.linear(1.0),
              textAlign: WrapAlignment.start,
              p: textStyle,
              h3: textStyle!.copyWith(fontSize: 24.0, fontWeight: FontWeight.bold),
              listBullet: textStyle,
            ),
          )
        : isSelectable
            ? SelectableText(
                text!.replaceAll("\\n", "\n"),
                textAlign: textAlign ?? TextAlign.left,
                maxLines: maxLines,
                style: textStyle,
              )
            : Text(
                text!.replaceAll("\\n", "\n"),
                textAlign: textAlign ?? TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: maxLines,
                softWrap: true,
                style: textStyle,
              );
    return isFit
        ? FittedBox(
            fit: BoxFit.scaleDown,
            child: textWidget,
          )
        : textWidget;
  }
}
