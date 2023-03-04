
import 'package:flutter/material.dart';

import '../../../core/styles.dart';

class OnBoardingListViewItem extends StatelessWidget {
  const OnBoardingListViewItem(
      {super.key,
        required this.image,
        required this.title,
        required this.description});

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 400,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Styles.onboardingText,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
