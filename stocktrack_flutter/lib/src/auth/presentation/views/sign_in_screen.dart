import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stocktrack_flutter/core/common/app/user_provider.dart';
import 'package:stocktrack_flutter/core/common/widgets/gradient_background_color.dart';
import 'package:stocktrack_flutter/core/common/widgets/rounded_button.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';
import 'package:stocktrack_flutter/core/res/fonts.dart';
import 'package:stocktrack_flutter/core/utils/core_utils.dart';
import 'package:stocktrack_flutter/core/utils/route_utils.dart';
import 'package:stocktrack_flutter/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:stocktrack_flutter/src/auth/presentation/widgets/sign_in_form.dart';

/// A screen for user sign-in.
///
/// This provides a user interface for users to sign in. It includes a form to
/// input username and password, a sign-in button, and error handling for
/// authentication. When the user successfully signs in, their authentication
/// token is saved using a [UserProvider], and they are navigated to the
/// dashboard.
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  /// The route name for this screen.
  static const routeName = '/signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Handles the sign-in process.
  void _signInHandler() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SignInEvent(
              username: usernameController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('SignInScreen: Build...');
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          debugPrint('SignInScreen.AuthState: $state');
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            // Save the user token to a provider.
            context.read<UserProvider>().initUserToken(
                  state.userLoginResponse.data!.token,
                );
            // Navigate to the dashboard.
            context.go(AppPage.dashboard.toPath);
          }
        },
        builder: (context, state) {
          return GradientBackgroundColor(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: Colours.gradientBackgroundSignIn,
            ),
            child: Center(
              child: Container(
                height: 350,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: Fonts.aeonik,
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SignInForm(
                        usernameController: usernameController,
                        passwordController: passwordController,
                        formKey: formKey,
                      ),
                      const SizedBox(height: 30),
                      if (state is AuthLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        RoundedButton(
                          label: 'Sign In',
                          onPressed: _signInHandler,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
