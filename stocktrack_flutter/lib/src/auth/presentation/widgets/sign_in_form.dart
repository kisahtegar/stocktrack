import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/core/common/widgets/i_field.dart';

/// A reusable sign-in form widget that includes input fields for email and
/// password.
class SignInForm extends StatefulWidget {
  /// Creates a [SignInForm] widget with required controllers and form key.
  const SignInForm({
    required this.usernameController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  /// The controller for the email input field.
  final TextEditingController usernameController;

  /// The controller for the password input field.
  final TextEditingController passwordController;

  /// A global key for the form associated with this sign-in form.
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
          /// Email input field
          IField(
            controller: widget.usernameController,
            hintText: 'Username',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 15),

          /// Password input field with show/hide password functionality
          IField(
            controller: widget.passwordController,
            hintText: 'Password',
            obscureText: obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscurePassword = !obscurePassword;
              }),
              icon: Icon(
                obscurePassword
                    ? Icons.remove_red_eye_outlined
                    : Icons.remove_red_eye,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
