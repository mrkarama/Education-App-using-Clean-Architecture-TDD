import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class Dimensions {
  const Dimensions._();

  // WIDTH = 411.4
  // HEIGHT = 804.6

  static double responsiveDimension(
    double scaleFactor,
    BuildContext context,
  ) =>
      context.height / scaleFactor;
}
