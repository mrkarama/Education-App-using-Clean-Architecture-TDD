import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:education_app/src/profile/widgets/profile_body_tile.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height * .3,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: Dimensions.responsiveDimension(80.46, context),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ProfileBodyTile(
                    icon: Icon(
                      IconlyLight.document,
                      color: Colors.deepPurple,
                      size: Dimensions.responsiveDimension(26.82, context),
                    ),
                    text: 'Courses',
                    total: context.currentUser!.enrolledCourseIds!.length,
                  ),
                ),
                Expanded(
                  child: ProfileBodyTile(
                    icon: Icon(
                      Icons.score_outlined,
                      color: Colors.green,
                      size: Dimensions.responsiveDimension(26.82, context),
                    ),
                    text: 'Scores',
                    total: context.currentUser!.enrolledCourseIds!.length,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ProfileBodyTile(
                  icon: Icon(
                    IconlyLight.user,
                    color: Colors.blue,
                    size: Dimensions.responsiveDimension(26.82, context),
                  ),
                  text: 'Followers',
                  total: context.currentUser!.enrolledCourseIds!.length,
                ),
              ),
              Expanded(
                child: ProfileBodyTile(
                  icon: Icon(
                    IconlyLight.user,
                    color: Colors.redAccent,
                    size: Dimensions.responsiveDimension(26.82, context),
                  ),
                  text: 'Following',
                  total: context.currentUser!.points!,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
