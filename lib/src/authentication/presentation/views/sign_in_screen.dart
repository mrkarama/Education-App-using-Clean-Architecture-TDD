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
import 'package:education_app/src/authentication/presentation/views/forgot_password_screen.dart';
import 'package:education_app/src/authentication/presentation/views/sign_up_screen.dart';
import 'package:education_app/src/authentication/presentation/widgets/sign_in_form.dart';
import 'package:education_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              } else if (state is UserSignedIn) {
                context.userProvider.user = state.user as LocalUserModel;
                Navigator.pushReplacementNamed(
                  context,
                  Dashboard.routeName,
                );
              }
            },
            builder: (context, state) {
              if (state is AuthenticationLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign in to your account',
                          style: TextStyle(
                            fontSize:
                                Dimensions.responsiveDimension(50.29, context),
                          ),
                        ),
                        Baseline(
                          baseline:
                              Dimensions.responsiveDimension(8.05, context),
                          baselineType: TextBaseline.alphabetic,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                SignUpScreen.routeName,
                              );
                            },
                            child: Text(
                              'Register account?',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: XColors.primaryColor,
                                fontSize: Dimensions.responsiveDimension(
                                  50.28,
                                  context,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.height * .04,
                    ),
                    SignInForm(
                      emailController: emailController,
                      passwordController: passwordController,
                      formKey: formKey,
                    ),
                    SizedBox(
                      height: context.height * .04,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ForgotPasswordScreen.routeName,
                          );
                        },
                        child: Text(
                          'Forgot password?',
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
                      height: context.height * .06,
                    ),
                    RoundedButton(
                      label: 'Sign In',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          sl<FirebaseAuth>().currentUser?.reload();
                          context.read<AuthenticationBloc>().add(
                                SignInEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                    ),
                    // if (state is AuthenticationLoading)
                    //   const Center(
                    //     child: CircularProgressIndicator(
                    //       valueColor: AlwaysStoppedAnimation<Color>(
                    //         Colors.white,
                    //       ),
                    //     ),
                    //   )
                    // else
                    //   RoundedButton(
                    //     label: 'Sign In',
                    //     onPressed: () {
                    //       if (formKey.currentState!.validate()) {
                    //         FocusManager.instance.primaryFocus?.unfocus();
                    //         sl<FirebaseAuth>().currentUser?.reload();
                    //         context.read<AuthenticationBloc>().add(
                    //               SignInEvent(
                    //                 email: emailController.text.trim(),
                    //                 password: passwordController.text.trim(),
                    //               ),
                    //             );
                    //       }
                    //     },
                    //   ),
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
