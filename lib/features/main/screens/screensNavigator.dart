import 'package:ecommerc/features/main/data/services/products_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/products/products_cubit.dart';
import '../data/repo/products_repo.dart';
import 'cartScreen.dart';
import 'homeScreen.dart';

class ScreensNavigator extends StatefulWidget {
  const ScreensNavigator({Key? key}) : super(key: key);

  @override
  State<ScreensNavigator> createState() => _ScreensNavigatorState();
}

class _ScreensNavigatorState extends State<ScreensNavigator> {
  int _page = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  Widget bodyFunction() {
    final ProductsRepo repo = ProductsRepo(ProductsService());
    switch (_page) {
      case 0:
        return BlocProvider(
            create: (context) => ProductsCubit(repo),
            child: const HomeScreen());
      case 1:
        return  CartScreen(repo: repo,);
      default:
        return Container(color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFunction(),
      bottomNavigationBar: BottomNavigationBar(
        key: _bottomNavigationKey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined, size: 30),
              label: "Cart"),
        ],
        selectedItemColor: const Color(0xffea9657),
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
