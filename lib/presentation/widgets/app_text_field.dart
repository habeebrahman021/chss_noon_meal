import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final Color cursorColor;
  final TextStyle style;
  final TextStyle hintStyle;
  final String? hintText;
  final Color fillColor;
  final double borderRadius;

   AppTextField({
    Key? key,
    this.cursorColor = Colors.black,
    this.style = const TextStyle(color: Colors.white),
    this.hintStyle = const TextStyle(color: Colors.blue),
    this.hintText,
    this.fillColor = AppColors.textColor,
    this.borderRadius = 25.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: cursorColor,
      style: style,
      decoration: InputDecoration(
        hintStyle: hintStyle,
        hintText: hintText,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
