import 'package:flutter/material.dart';
import 'package:online_store_tk/src/screen.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final String fontFamily;
  final Color colorText;
  const TextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontFamily = "MonB",
    this.colorText = AppColors.oscureColor,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
          color: colorText,
        ),
      ),
    );
  }
}
