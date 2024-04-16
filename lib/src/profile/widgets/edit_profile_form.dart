import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/extensions/string_extensions.dart';
import 'package:education_app/src/profile/widgets/edit_profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.fullNameController,
    required this.emailController,
    required this.bioController,
    required this.newPasswordController,
    required this.oldPassowrdController,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController bioController;
  final TextEditingController newPasswordController;
  final TextEditingController oldPassowrdController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileTextField(
          fieldtitle: 'FULL NAME',
          controller: fullNameController,
          hintText: fullNameController.text.trim(),
        ),
        EditProfileTextField(
          fieldtitle: 'EMAIL',
          controller: emailController,
          hintText: context.currentUser!.email.obscureEmail,
        ),
        EditProfileTextField(
          fieldtitle: 'CURRENT PASSWORD',
          controller: oldPassowrdController,
          hintText: '******',
        ),
        StatefulBuilder(
          builder: (_, setState) {
            oldPassowrdController.addListener(() => setState(() {}));
            return EditProfileTextField(
              fieldtitle: 'PASSWORD',
              controller: newPasswordController,
              hintText: '******',
              readOnly: oldPassowrdController.text.isEmpty,
            );
          },
        ),
        EditProfileTextField(
          fieldtitle: 'BIO',
          controller: bioController,
          hintText: bioController.text.trim(),
        ),
      ],
    );
  }
}
