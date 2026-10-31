import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/MainPage/presentation/pages/main_screen.dart';
import 'features/splash/presentation/pages/splash_pages/splash_page.dart';

abstract class AppPaths {
  static const splash = _SplashPaths();
  static const main = _MainPaths();
}

class _SplashPaths {
  const _SplashPaths();

  String get splash => '/';
}

class _MainPaths {
  const _MainPaths();

  final String _base = '/main';

  String get home => '$_base/home';

  @override
  String toString() => _base;
}

/// Creates the single [GoRouter] instance of the app. Never recreate it.
GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppPaths.splash.splash,
    routes: <GoRoute>[
      GoRoute(
        path: AppPaths.splash.splash,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashPage(),
      ),
      GoRoute(
        path: '${AppPaths.main}/:section',
        builder: (BuildContext context, GoRouterState state) {
          return MainScreen(
            section: '/main/${state.pathParameters['section']}',
          );
        },
      ),
    ],
  );
}
