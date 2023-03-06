import 'package:ecommerc/features/main/data/repo/products_repo.dart';
import 'package:flutter/material.dart';

import '../data/models/product.dart';

class SingleCartItem extends StatelessWidget {
  SingleCartItem({
    super.key,
    required this.product,
    required this.repo,
    required this.cartTotal
  });
   int cartTotal = 0;
  final Product product;
  final ProductsRepo repo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          leading: Image.network(
            product.thumbnail,
            height: 36,
          ),
          title: Text(
            product.title,
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            '\$ ${product.price}',
            style: const TextStyle(fontSize: 12),
          ),
          trailing:
              IconButton(icon: const Icon(Icons.cancel), onPressed: () {

                cartTotal -= product.price;
                repo.deleteProductFromCart(product);
              }),
        ),
      ),
    );
  }
}
