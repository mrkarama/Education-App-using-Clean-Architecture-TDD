import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/res/colors.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        final userImage = user!.profilePic == null || user.profilePic!.isEmpty
            ? null
            : user.profilePic;
        final userBio =
            provider.user!.bio == null || provider.user!.bio!.isEmpty
                ? null
                : provider.user!.bio;
        return Column(
          children: [
            SizedBox(
              height: context.height * 0.13,
            ),
            CircleAvatar(
              radius: Dimensions.responsiveDimension(13.87, context),
              backgroundImage: userImage != null
                  ? NetworkImage(userImage)
                  : const AssetImage(MediaRes.defaultUser) as ImageProvider,
            ),
            SizedBox(
              height: context.height * 0.02,
            ),
            Text(
              context.currentUser!.name,
              style: TextStyle(
                fontSize: Dimensions.responsiveDimension(30.9, context),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: context.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.height * .15,
              ),
            ),
            if (userBio != null) ...[
              Text(
                context.currentUser!.bio!,
                style: TextStyle(
                  fontSize: Dimensions.responsiveDimension(47.33, context),
                  fontWeight: FontWeight.w400,
                  color: XColors.neutralTextColor,
                ),
              ),
            ],
            SizedBox(
              height: context.height * .06,
            ),
          ],
        );
      },
    );
  }
}
