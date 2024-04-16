import 'dart:async';
import 'package:education_app/core/common/app/providers/tab_navigator.dart';
import 'package:education_app/core/common/widgets/popup_item.dart';
import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:education_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:education_app/src/profile/widgets/edit_profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Account',
        style: TextStyle(
          fontSize: Dimensions.responsiveDimension(28.73, context),
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(
            Icons.more_horiz,
          ),
          surfaceTintColor: Colors.white,
          offset: Offset(0, Dimensions.responsiveDimension(16.1, context)),
          itemBuilder: (context) => [
            PopupMenuItem<void>(
              onTap: () => context.push(
                TabItem(
                  child: BlocProvider(
                    create: (_) => sl<AuthenticationBloc>(),
                    child: const EditProfileView(),
                  ),
                ),
              ),
              child: const PopupItem(
                title: 'Edit profile',
                icon: Icon(
                  IconlyLight.edit,
                ),
              ),
            ),
            const PopupMenuItem<void>(
              child: PopupItem(
                title: 'Notification',
                icon: Icon(
                  IconlyLight.notification,
                ),
              ),
            ),
            const PopupMenuItem<void>(
              child: PopupItem(
                title: 'Help',
                icon: Icon(
                  Icons.help_outline,
                  color: Colors.black54,
                ),
              ),
            ),
            PopupMenuItem<void>(
              height: 1,
              padding: EdgeInsets.zero,
              child: Divider(
                height: 1,
                color: Colors.black45,
                indent: Dimensions.responsiveDimension(67, context),
                endIndent: Dimensions.responsiveDimension(67, context),
              ),
            ),
            PopupMenuItem<void>(
              onTap: () async {
                final navigator = Navigator.of(context);
                await sl<FirebaseAuth>().signOut();
                unawaited(
                  navigator.pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  ),
                );
              },
              child: const PopupItem(
                title: 'Logout',
                icon: Icon(
                  IconlyLight.logout,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
