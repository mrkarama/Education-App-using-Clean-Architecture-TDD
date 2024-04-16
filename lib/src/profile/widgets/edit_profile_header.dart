import 'dart:io';

import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/res/colors.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({
    required this.pickedImage,
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;
  final File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.13,
        ),
        Builder(
          builder: (context) {
            final user = context.currentUser!;
            final userImage =
                user.profilePic == null || user.profilePic!.isEmpty
                    ? null
                    : user.profilePic!;
            return CircleAvatar(
              radius: Dimensions.responsiveDimension(13.87, context),
              backgroundImage: pickedImage != null
                  ? FileImage(pickedImage!)
                  : userImage != null
                      ? NetworkImage(userImage)
                      : const AssetImage(MediaRes.defaultUser) as ImageProvider,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: Dimensions.responsiveDimension(6.936, context),
                    height: Dimensions.responsiveDimension(6.936, context),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(
                        Dimensions.responsiveDimension(13.87, context),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      userImage != null || pickedImage != null
                          ? Icons.edit
                          : Icons.add_a_photo,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
          child: Text(
            'We recommend an image of at least 400*400',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Dimensions.responsiveDimension(50.28, context),
              fontWeight: FontWeight.w400,
              color: XColors.neutralTextColor,
            ),
          ),
        ),
        SizedBox(
          height: context.height * .04,
        ),
      ],
    );
  }
}
