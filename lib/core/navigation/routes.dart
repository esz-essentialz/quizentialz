import 'package:go_router/go_router.dart';
import 'package:quizentialz/core/api/local.storage.dart';
import 'package:quizentialz/core/navigation/pages.dart';
import 'package:quizentialz/core/presentation/auth/auth.page.dart';
import 'package:quizentialz/core/presentation/landing/landing.page.dart';
import 'package:quizentialz/core/presentation/main/main.page.dart';

class Routes {
  Routes._();

  static final router = GoRouter(
    initialLocation: (Storage.pref.getBool("LOGGED_IN") ?? false) ? Pages.MAIN_PAGE : Pages.MAIN_PAGE,
    routes: [
      GoRoute(
        name: Pages.LANDING_PAGE,
        path: Pages.LANDING_PAGE,
        builder: (context, state) => LandingPage(),
      ),
      GoRoute(
        name: Pages.MAIN_PAGE,
        path: Pages.MAIN_PAGE,
        builder: (context, state) => MainPage(),
      ),
      GoRoute(
        name: Pages.AUTH_PAGE,
        path: Pages.AUTH_PAGE,
        builder: (context, state) => AuthPage(),
      ),
    ],
  );
}
