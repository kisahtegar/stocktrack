import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:stocktrack_flutter/core/services/injection_container.dart';
import 'package:stocktrack_flutter/core/services/router.dart';

Future<void> main() async {
  setUrlStrategy(PathUrlStrategy());

  // Initialize other app dependencies.
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StockTrack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade400),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: Fonts.poppins,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
    );
  }
}
