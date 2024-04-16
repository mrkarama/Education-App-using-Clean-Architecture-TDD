import 'package:education_app/core/common/widgets/xfield.dart';
import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _obscurePassword = false;
  bool _obscureConfirmPassword = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          XField(
            controller: widget.nameController,
            keyboardType: TextInputType.text,
            hintText: 'Full Name',
          ),
          SizedBox(
            height: context.height * .04,
          ),
          XField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Email Address',
          ),
          SizedBox(
            height: context.height * .04,
          ),
          XField(
            controller: widget.passwordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Password',
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword ? IconlyLight.show : IconlyLight.hide,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: context.height * .04,
          ),
          XField(
            controller: widget.confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Confirm Password',
            obscureText: _obscureConfirmPassword,
            overrideValidator: true,
            validator: (value) {
              if (widget.passwordController.text != value) {
                return 'Passwords do not match';
              }
              return null;
            },
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              icon: Icon(
                _obscureConfirmPassword ? IconlyLight.show : IconlyLight.hide,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
