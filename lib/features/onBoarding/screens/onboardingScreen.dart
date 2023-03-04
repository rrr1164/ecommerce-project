import 'package:ecommerc/core/appRouter.dart';
import 'package:ecommerc/core/styles.dart';
import 'package:ecommerc/features/onBoarding/widgets/onBoardListViewItem.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/assets.dart';
import '../widgets/navigationButton.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
    // reached last page

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 470,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardData.length,
                  itemBuilder: (context, index) => OnBoardingListViewItem(
                    image: onboardData[index].image,
                    title: onboardData[index].title,
                    description: onboardData[index].description,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(25),
                  child: NavigationButton(pageController: _pageController))
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardItem {
  final String image, title, description;

  OnboardItem(
      {required this.image, required this.title, required this.description});
}

final List<OnboardItem> onboardData = [
  OnboardItem(
      image: Assets.firstOnBoardingIllustration,
      title: "Your Appearance Shows Quality",
      description: "Change the quality of your Appearance Now!"),
  OnboardItem(
      image: Assets.secondOnBoardingIllustration,
      title: "Buy anything you want!",
      description: "It's That Simple"),
  OnboardItem(
      image: Assets.thirdOnBoardingIllustration,
      title: "Get your order!",
      description: "Order Now!"),
];




