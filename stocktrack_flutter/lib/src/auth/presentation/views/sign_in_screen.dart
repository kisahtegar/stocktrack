import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocktrack_flutter/core/common/widgets/gradient_background_color.dart';
import 'package:stocktrack_flutter/core/common/widgets/rounded_button.dart';
import 'package:stocktrack_flutter/core/res/colours.dart';
import 'package:stocktrack_flutter/core/res/fonts.dart';
import 'package:stocktrack_flutter/src/auth/presentation/cubit/auth_cubit.dart';
import 'package:stocktrack_flutter/src/auth/presentation/widgets/sign_in_form.dart';
import 'package:stocktrack_flutter/src/dashboard/presentation/views/dashboard.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            // CoreUtils.showSnackBar(context, state.message);
            debugPrint('SignInScreen: AuthError{$state}');
          } else if (state is SignedIn) {
            debugPrint('SignInScreen: Im here');
            // context.read<UserProvider>().initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(context, Dashboard.routeName);
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
                      RoundedButton(
                        label: 'Sign In',
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          // TODO(kisahtegar): Do action in here.
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().signIn(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                );
                          }
                        },
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
