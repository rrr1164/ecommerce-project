import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/appRouter.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: ElevatedButton(
        onPressed: () {
          // reached last page
          if (_pageController.page == 2) {
            navigateToRegister(context);
          } else {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }
        },
        style: ElevatedButton.styleFrom(shape: const CircleBorder()),
        child: const Icon(
          Icons.arrow_forward_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
void navigateToRegister(BuildContext context) {
  GoRouter.of(context).go(AppRouter.kRegisterScreen);
}