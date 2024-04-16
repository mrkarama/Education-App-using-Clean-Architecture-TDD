import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/rounded_button.dart';
import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/res/colors.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:education_app/src/authentication/presentation/views/sign_in_screen.dart';
import 'package:education_app/src/authentication/presentation/widgets/sign_up_form.dart';
import 'package:education_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GradientBackground(
          image: MediaRes.authGradientBackground,
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationError) {
                CoreUtils.showSnackar(
                  context: context,
                  message: state.message,
                );
              } else if (state is UserSignedUp) {
                context.read<AuthenticationBloc>().add(
                      SignInEvent(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    );
              } else if (state is UserSignedIn) {
                context.userProvider.user = state.user as LocalUserModel;
                Navigator.pushReplacementNamed(
                  context,
                  Dashboard.routeName,
                );
              }
            },
            builder: (context, state) {
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.responsiveDimension(
                      40.23,
                      context,
                    ),
                  ),
                  children: [
                    Text(
                      'Easy to learn, discover more skills.',
                      style: TextStyle(
                        fontFamily: Fonts.aeonik,
                        fontSize:
                            Dimensions.responsiveDimension(25.14, context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: context.height * .02,
                    ),
                    Text(
                      'Sign up to for an account',
                      style: TextStyle(
                        fontSize:
                            Dimensions.responsiveDimension(50.28, context),
                      ),
                    ),
                    SizedBox(
                      height: context.height * .03,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            SignInScreen.routeName,
                          );
                        },
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: XColors.primaryColor,
                            fontSize:
                                Dimensions.responsiveDimension(50.28, context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.height * .04,
                    ),
                    SignUpForm(
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      formKey: formKey,
                    ),
                    SizedBox(
                      height: context.height * .06,
                    ),
                    if (state is AuthenticationLoading) ...[
                      const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ] else ...[
                      RoundedButton(
                        label: 'Sign Up',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            sl<FirebaseAuth>().currentUser?.reload();
                            context.read<AuthenticationBloc>().add(
                                  SignUpEvent(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
