import 'dart:async';

import 'package:ecommerc/features/main/widgets/singleProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/products/products_cubit.dart';
import '../cubit/products/products_state.dart';
import '../data/models/product.dart';

Widget productsList(ScrollController scrollController) {
  return BlocBuilder<ProductsCubit, ProductsState>(builder: (context, state) {
    if (state is ProductsLoading && state.isFirstFetch) {
      return _loadingIndicator();
    }
    List<Product> products = [];
    bool isLoading = false;
    if (state is ProductsLoading) {
      products = state.oldProducts;
      isLoading = true;
    } else if (state is ProductsLoaded) {
      products = state.products;
    }
    return GridView.builder(
      itemBuilder: (context, index) {
        if (index < products.length) {
          return SingleProduct(product: products[index]);
        } else {
          Timer(const Duration(milliseconds: 30), () {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
          return _loadingIndicator();
        }
      },
      itemCount: products.length + (isLoading ? 1 : 0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.53 / 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5),
    );
  });
}

Widget _loadingIndicator() {
  return const Padding(
    padding: EdgeInsets.all(8),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
