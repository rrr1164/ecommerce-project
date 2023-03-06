import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/assets.dart';
import '../cubit/products/products_cubit.dart';
import '../widgets/productsList.dart';
import '../widgets/searchbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? profileIcon = FirebaseAuth.instance.currentUser?.photoURL;
  final ScrollController scrollController = ScrollController();

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<ProductsCubit>(context).loadProducts();
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductsCubit>(context).loadProducts();
    setupScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(deviceWidth, 80),
          child:
              CustomAppBar(deviceWidth: deviceWidth, profileIcon: profileIcon)),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(16.0), child: SearchBar()),
            productsList(scrollController)
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.deviceWidth,
    required this.profileIcon,
  });

  final double deviceWidth;
  final String? profileIcon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(Assets.appLogo),
              Padding(
                padding: const EdgeInsets.all(6),
                child: CircleAvatar(
                  backgroundColor: const Color(0xffb2b5ad),
                  radius: 22,
                  child: ClipOval(
                    child: Image.network(
                      profileIcon!,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
