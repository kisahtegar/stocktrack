import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stocktrack_flutter/src/auth/presentation/cubit/auth_cubit.dart';
// import 'package:stocktrack_flutter/src/auth/presentation/views/sign_in_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  /// The route name for this screen.
  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Dashboard: Build...');
    return const Center(
      child: Text('DASHBOARDD'),
    );
    // return BlocConsumer<AuthCubit, AuthState>(
    //   listener: (context, state) {
    //     debugPrint('Dashboard(listener): state is $state');
    //     if (state is NotLoggedIn) {
    //       // User logged out, navigate to the login screen.
    //       Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
    //     }
    //   },
    //   builder: (context, state) {
    //     debugPrint('Dashboard(builder): state is $state');
    //     return Center(
    //       child: Text('DASHBOARD'),
    //     );
    //   },
    // );
  }
}
