
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/products/products_cubit.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
          hintText: "Search Product",
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: Colors.black87,
          fillColor: const Color(0xfffafafa),),
      onChanged:     (text) {
        BlocProvider.of<ProductsCubit>(context).searchProducts(
            text);
      },
    );
  }
}
