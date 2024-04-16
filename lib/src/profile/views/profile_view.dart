import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:education_app/src/profile/widgets/profile_app_bar.dart';
import 'package:education_app/src/profile/widgets/profile_body.dart';
import 'package:education_app/src/profile/widgets/profile_header.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaRes.profileGradientBackground,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.responsiveDimension(40.23, context),
          ),
          children: const [
            ProfileHeader(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }
}
