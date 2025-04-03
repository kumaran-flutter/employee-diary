import 'package:flutter/material.dart';

import '../styles/styles.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.validator,
    this.errorStyle,
  });
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final void Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextStyle? errorStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        hintText: hintText,
        hintStyle: PrimaryTextStyle.primaryStyle3,
        errorStyle: errorStyle,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderGray, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderGray, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderGray, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderGray, width: 2),
        ),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      style: TextStyle(fontSize: 16),
      cursorColor: Colors.blue,
      onTap: onTap,
      onChanged: (value) {
        // Handle text change
      },
    );
  }
}
