import 'package:education_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class PopupItem extends StatelessWidget {
  const PopupItem({
    required this.title,
    required this.icon,
    super.key,
  });

  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Dimensions.responsiveDimension(44.7, context),
            fontWeight: FontWeight.w400,
          ),
        ),
        icon,
      ],
    );
  }
}
