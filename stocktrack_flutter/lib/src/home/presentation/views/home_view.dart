import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/src/home/presentation/refactors/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: HomeBody(),
    );
  }
}
