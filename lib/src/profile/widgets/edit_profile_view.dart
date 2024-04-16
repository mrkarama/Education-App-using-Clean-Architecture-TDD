import 'dart:convert';
import 'dart:io';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/nested_back_button.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/res/colors.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:education_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:education_app/src/profile/widgets/edit_profile_form.dart';
import 'package:education_app/src/profile/widgets/edit_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController bioController;
  late TextEditingController oldPassowrdController;
  late TextEditingController newPasswordController;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    newPasswordController = TextEditingController();
    oldPassowrdController = TextEditingController();
    bioController = TextEditingController();

    fullNameController.text = context.currentUser!.name;
    bioController.text = context.currentUser!.bio ?? '';
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    bioController.dispose();
    newPasswordController.dispose();
    oldPassowrdController.dispose();
    super.dispose();
  }

  File? pickedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  bool get namedChanged =>
      fullNameController.text.trim() != context.currentUser!.name.trim();

  bool get emailChanged => emailController.text.isNotEmpty;

  bool get bioChanged =>
      bioController.text.trim() != context.currentUser!.bio?.trim();

  bool get newPasswordChanged => newPasswordController.text.isNotEmpty;

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !namedChanged &&
      !emailChanged &&
      !bioChanged &&
      !newPasswordChanged &&
      !imageChanged;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (_, state) {
        if (state is UserDataUpdated) {
          CoreUtils.showSnackar(
            context: context,
            message: 'User profile updated successfully',
          );
          context.pop();
        } else if (state is AuthenticationError) {
          CoreUtils.showSnackar(
            context: context,
            message: state.message,
          );
        }
      },
      builder: (_, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: Dimensions.responsiveDimension(28.73, context),
                fontWeight: FontWeight.w700,
              ),
            ),
            leading: const NestedBackButton(),
            actions: [
              TextButton(
                onPressed: () {
                  if (nothingChanged) {
                    context.pop();
                  }

                  final bloc = context.read<AuthenticationBloc>();
                  if (newPasswordChanged) {
                    if (oldPassowrdController.text.isEmpty) {
                      CoreUtils.showSnackar(
                        context: context,
                        message: 'Please enter your old password',
                      );
                      return;
                    }
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.password,
                        userData: jsonEncode(
                          {
                            'oldPassword': oldPassowrdController.text.trim(),
                            'newPassword': newPasswordController.text.trim(),
                          },
                        ),
                      ),
                    );
                  }

                  if (namedChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.displayName,
                        userData: fullNameController.text.trim(),
                      ),
                    );
                  }

                  if (emailChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.email,
                        userData: emailController.text.trim(),
                      ),
                    );
                  }

                  if (bioChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.bio,
                        userData: bioController.text.trim(),
                      ),
                    );
                  }

                  if (imageChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.profilePic,
                        userData: pickedImage,
                      ),
                    );
                  }
                },
                child: state is AuthenticationLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          XColors.primaryColor,
                        ),
                      )
                    : StatefulBuilder(
                        builder: (_, refresh) {
                          oldPassowrdController
                              .addListener(() => refresh(() {}));
                          newPasswordController
                              .addListener(() => refresh(() {}));
                          fullNameController.addListener(() => refresh(() {}));
                          emailController.addListener(() => refresh(() {}));
                          bioController.addListener(() => refresh(() {}));
                          return Text(
                            'Done',
                            style: TextStyle(
                              fontSize: Dimensions.responsiveDimension(
                                40.23,
                                context,
                              ),
                              fontWeight: FontWeight.w500,
                              color: nothingChanged
                                  ? Colors.grey
                                  : XColors.primaryColor,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          body: GradientBackground(
            image: MediaRes.profileGradientBackground,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.responsiveDimension(40.23, context),
              ),
              children: [
                EditProfileHeader(
                  pickedImage: pickedImage,
                  onPressed: pickImage,
                ),
                EditProfileForm(
                  fullNameController: fullNameController,
                  emailController: emailController,
                  bioController: bioController,
                  newPasswordController: newPasswordController,
                  oldPassowrdController: oldPassowrdController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
