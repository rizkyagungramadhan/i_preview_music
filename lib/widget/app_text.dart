import 'package:flutter/material.dart';
import 'package:i_preview_music/style/app_text_style.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 5/17/2022.


class AppText extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  const AppText(this.text, {this.maxLines = 1, this.style, this.textAlign, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: style ?? AppTextStyle.light(),
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
