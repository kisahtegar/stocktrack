import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';
import 'package:stocktrack_flutter/core/common/app/user_provider.dart';
import 'package:stocktrack_flutter/core/services/app_router.dart';
import 'package:stocktrack_flutter/core/services/injection_container.dart';
import 'package:stocktrack_flutter/src/dashboard/presentation/providers/dashboard_controller.dart';

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
    return MultiProvider(
      providers: [
        // Provide the UserProvider for managing user-related data.
        ChangeNotifierProvider(create: (_) => UserProvider()),

        // Provide the DashboardController for controlling dashboard state.
        ChangeNotifierProvider(create: (_) => DashboardController()),
      ],
      child: MaterialApp.router(
        title: 'StockTrack',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade400),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // fontFamily: Fonts.poppins,
        ),
        debugShowCheckedModeBanner: false,
        // onGenerateRoute: generateRoute,
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
      ),
    );
  }
}
