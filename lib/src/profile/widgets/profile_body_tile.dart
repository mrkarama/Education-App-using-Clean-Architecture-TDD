import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ProfileBodyTile extends StatelessWidget {
  const ProfileBodyTile({
    required this.icon,
    required this.text,
    required this.total,
    super.key,
  });

  final Widget icon;
  final String text;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(
          Dimensions.responsiveDimension(40.23, context),
        ).copyWith(
          left: context.width / 41.14,
        ),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: context.width * 0.03,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: Dimensions.responsiveDimension(44, context),
                  ),
                ),
                Text(
                  total.toString(),
                  style: TextStyle(
                    fontSize: Dimensions.responsiveDimension(40.21, context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
