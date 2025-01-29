import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizentialz/core/api/client.appwrite.dart';
import 'package:quizentialz/core/api/local.storage.dart';
import 'package:quizentialz/core/navigation/routes.dart';
import 'core/theme/theme.dart';

void main() async {
  AppwriteClient.init();
  await Storage.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    GoTransition.defaultCurve = Curves.easeInOut;
    GoTransition.defaultDuration = const Duration(milliseconds: 600);

    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: GoTransitions.fadeUpwards,
            TargetPlatform.windows: GoTransitions.fadeUpwards,
          },
        ),
        textTheme: GoogleFonts.syneTextTheme(),
        primaryColor: Themes.btnColor,
        scaffoldBackgroundColor: Themes.backgroundColor,
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Themes.backgroundLightColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Themes.backgroundLightColor),
          ),
        ),
      ),
      routeInformationParser: Routes.router.routeInformationParser,
      routeInformationProvider: Routes.router.routeInformationProvider,
      routerDelegate: Routes.router.routerDelegate,
    );
  }
}
