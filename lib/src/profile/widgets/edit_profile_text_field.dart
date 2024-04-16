import 'package:education_app/core/common/widgets/xfield.dart';
import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    required this.fieldtitle,
    required this.controller,
    required this.hintText,
    super.key,
    this.readOnly,
  });

  final String fieldtitle;
  final TextEditingController controller;
  final bool? readOnly;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: Dimensions.responsiveDimension(100, context),
          ),
          child: Text(
            fieldtitle,
            style: TextStyle(
              fontSize: Dimensions.responsiveDimension(47.33, context),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: context.height * .015,
        ),
        XField(
          controller: controller,
          keyboardType: TextInputType.text,
          hintText: hintText,
          readOnly: readOnly,
        ),
        SizedBox(
          height: context.height * .02,
        ),
      ],
    );
  }
}
