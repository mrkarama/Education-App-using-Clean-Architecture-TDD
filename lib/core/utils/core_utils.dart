import 'package:education_app/core/res/colors.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          backgroundColor: XColors.primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.responsiveDimension(
                80.46,
                context,
              ),
            ),
            borderSide: const BorderSide(
              color: XColors.primaryColor,
            ),
          ),
          margin: EdgeInsets.all(
            Dimensions.responsiveDimension(
              40.23,
              context,
            ),
          ).copyWith(top: 0),
        ),
      );
  }
}
