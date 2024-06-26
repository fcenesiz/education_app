import 'package:education_app/core/common/widgets/i_field.dart';
import 'package:education_app/core/extensions/num_extension.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignInForm extends StatefulWidget {
  const SignInForm(
      {required this.emailController,
      required this.passwordController,
      required this.formKey,
      super.key});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            IField(
              controller: widget.emailController,
              hintText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
            ),
            25.height,
            IField(
              controller: widget.passwordController,
              hintText: 'Password',
              obscureText: obscurePassword,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                icon:
                    Icon(obscurePassword ? IconlyLight.show : IconlyLight.hide),
              ),
            ),
          ],
        ));
  }
}
