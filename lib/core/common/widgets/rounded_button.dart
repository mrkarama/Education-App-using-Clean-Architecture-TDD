import 'package:education_app/core/res/colors.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.label,
    required this.onPressed,
    this.buttonWidth,
    this.foregroundColor,
    this.backgroundColor,
    super.key,
  });

  final String label;
  final Color? foregroundColor;
  final double? buttonWidth;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? XColors.primaryColor,
        foregroundColor: foregroundColor ?? Colors.white,
        minimumSize: Size(
          buttonWidth ?? double.maxFinite,
          Dimensions.responsiveDimension(16.1, context),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: Dimensions.responsiveDimension(
            44.7,
            context,
          ),
        ),
      ),
    );
  }
}
