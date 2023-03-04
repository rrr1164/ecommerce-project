import 'package:ecommerc/features/authentication/screens/registerScreen.dart';
import 'package:ecommerc/features/main/data/repo/products_repo.dart';
import 'package:ecommerc/features/onBoarding/screens/onboardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/main/data/services/products_services.dart';
import '../features/main/screens/homeScreen.dart';
import '../features/main/screens/screensNavigator.dart';
import 'utils/initialRouter.dart';

abstract class AppRouter {
  static const String kOnBoardingScreen = '/onBoarding';
  static const String kRegisterScreen = '/Register';
  static const String kScreensNavigator = '/ScreensNavigator';
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const InitialRouterScreen();
        },
      ),
      GoRoute(
        path: kOnBoardingScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const OnBoardingScreen();
        },
      ),
      GoRoute(
        path: kRegisterScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: kScreensNavigator,
        builder: (BuildContext context, GoRouterState state) {
          return const ScreensNavigator();
        },
      ),
    ],
  );
}
