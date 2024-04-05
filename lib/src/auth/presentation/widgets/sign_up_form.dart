import 'package:education_app/core/common/widgets/i_field.dart';
import 'package:education_app/core/extensions/num_extension.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            IField(
              controller: widget.fullNameController,
              hintText: 'Full Name',
              keyboardType: TextInputType.name,
            ),
            25.height,
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
            25.height,
            IField(
              controller: widget.confirmPasswordController,
              hintText: 'Confirm Password',
              obscureText: obscureConfirmPassword,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                },
                icon: Icon(
                  obscureConfirmPassword ? IconlyLight.show : IconlyLight.hide,
                ),
              ),
              overrideValidator: true,
              validator: (value) {
                if (value != widget.passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
          ],
        ));
  }
}
