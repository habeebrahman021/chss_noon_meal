import 'package:chss_noon_meal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.cursorColor = Colors.black,
    this.style = const TextStyle(color: Colors.white),
    this.hintStyle = const TextStyle(color: Colors.blue),
    this.hintText,
    this.fillColor = AppColors.textColor,
    this.borderRadius = 25.0,
  });

  final Color cursorColor;
  final TextStyle style;
  final TextStyle hintStyle;
  final String? hintText;
  final Color fillColor;
  final double borderRadius;

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
