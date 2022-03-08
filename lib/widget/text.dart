import 'package:flutter/material.dart';
import 'package:test/size.dart';


class TXT extends StatelessWidget {
  TXT(
      { this.text,
       this.color,
       this.fontSize,
       this.fontWeight,
       this.textAlign,
       this.edgeInset,
       this.height, 
       this.textDecorationStyle,
      });

  final String? text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  final TextAlign? textAlign;
  final TextDecorationStyle? textDecorationStyle;
  final EdgeInsets? edgeInset;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInset ?? EdgeInsets.all(0),
      child: Text(
        text!,
        style: TextStyle(
            color: color,
            decorationStyle: textDecorationStyle ?? TextDecorationStyle.solid,
            fontSize: fontSize ?? 13,
            fontWeight: fontWeight ?? FontWeight.normal,
            letterSpacing: -.7,
            height: height
            ),
        softWrap: true,
        textAlign: textAlign ?? TextAlign.left,
      ),
    );
  }
}