import 'package:ecommerc/core/appRouter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          primarySwatch: Constants.kAppTheme,
          fontFamily: GoogleFonts.poppins().fontFamily),
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
