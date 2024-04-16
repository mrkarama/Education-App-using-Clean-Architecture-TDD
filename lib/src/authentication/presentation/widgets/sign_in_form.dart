import 'package:education_app/core/common/widgets/xfield.dart';
import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _obscurePassword = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}
