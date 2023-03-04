import 'package:ecommerc/core/appRouter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialRouterScreen extends StatefulWidget {
  const InitialRouterScreen({Key? key}) : super(key: key);

  @override
  State<InitialRouterScreen> createState() => _InitialRouterScreenState();
}

class _InitialRouterScreenState extends State<InitialRouterScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  @override
  void initState() {
    super.initState();
    initFirebase().whenComplete(() => routeUser());
  }

  Future<void> initFirebase() async {
    await Firebase.initializeApp();
    return;
  }

  Future<void> routeUser() async {
    bool isFirstTime = await firstTime();
    if (isFirstTime) {
      if (context.mounted) {
        GoRouter.of(context).go(AppRouter.kOnBoardingScreen);
      }
    } else {
      print("user: ${FirebaseAuth.instance.currentUser}");
      if (FirebaseAuth.instance.currentUser == null) {
        if (context.mounted) GoRouter.of(context).go(AppRouter.kRegisterScreen);
      } else {
        if (context.mounted) GoRouter.of(context).go(AppRouter.kScreensNavigator);
      }
    }
  }

  Future<bool> firstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("initScreen") != null) {
      return false;
    } else {
      prefs.setBool("initScreen", true);
      return true;
    }
  }
}
