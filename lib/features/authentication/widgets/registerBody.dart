import 'package:flutter/material.dart';

import '../../../core/assets.dart';
import '../../../core/constants.dart';
import '../../../core/utils/authentication.dart';
import 'GoogleSignInButton.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        Assets.appLogo,
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
             const GoogleSignInButton()
        ],
          ),
        ),
      ),
    );
  }
}
