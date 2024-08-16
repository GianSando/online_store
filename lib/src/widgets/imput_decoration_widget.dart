import 'package:flutter/material.dart';
import 'package:online_store_tk/src/utils/app_colors.dart';

class ImputDecorationWidget extends StatelessWidget {
  final TextInputType keyboardType;
  //obsureText opcional
  final bool obscureText;
  //maxLines opcional
  final int? maxLines;
  //readonly opcional
  final bool readOnly;
  final String hintText;
  final String labelText;
  //prefixIcon opcional
  final Widget? prefixIcon;
  //suffixIcon opcional
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Color color;

  const ImputDecorationWidget({
    super.key,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines,
    this.readOnly = false,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.controller,
    this.color = AppColors.oscureColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      readOnly: readOnly,
      validator: validator,
      controller: controller,
      onTap: onTap,
      style: TextStyle(
        color: color,
        fontFamily: "MonM",
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontFamily: "MonM",
        ),
        hintStyle: TextStyle(
          color: AppColors.oscureColor.withOpacity(0.5),
          fontFamily: "MonM",
        ),
        labelStyle: TextStyle(
          color: color,
          fontFamily: "MonM",
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
      ),
    );
  }
}
