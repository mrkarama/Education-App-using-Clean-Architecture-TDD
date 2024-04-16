import 'package:education_app/core/res/colors.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class XField extends StatelessWidget {
  const XField({
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.readOnly,
    this.filled,
    this.fillColor,
    this.hintStyle,
    this.validator,
    this.overrideValidator = false,
    super.key,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool? obscureText;
  final bool? readOnly;
  final String hintText;
  final Widget? suffixIcon;
  final bool? filled;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final bool? overrideValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      validator: overrideValidator!
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return validator?.call(value);
            },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        focusColor: XColors.primaryColor,
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dimensions.responsiveDimension(40.23, context),
        ),
        filled: filled,
        fillColor: fillColor,
        hintStyle: hintStyle ??
            TextStyle(
              fontSize: Dimensions.responsiveDimension(50.29, context),
            ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(
            Dimensions.responsiveDimension(32.18, context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(
            Dimensions.responsiveDimension(32.18, context),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: XColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(
            Dimensions.responsiveDimension(32.18, context),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: XColors.redColor,
          ),
          borderRadius: BorderRadius.circular(
            Dimensions.responsiveDimension(32.18, context),
          ),
        ),
      ),
    );
  }
}
