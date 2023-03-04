import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerc/features/main/data/repo/products_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/models/product.dart';
import '../widgets/singleCartItem.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required this.repo}) : super(key: key);
  final ProductsRepo repo;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Text(
              "My Cart",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('carts')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  final dynamicProducts = snapshot.data!['cart'];
                  if (dynamicProducts.isNotEmpty) {
                    List<Product> products =
                        widget.repo.convertDynamicToProducts(dynamicProducts);
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return SingleCartItem(
                                product: products[index],
                                repo: widget.repo,
                              );
                            },
                            itemCount: products.length,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.repo.deleteCart();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              child: const Text("Purchase Items",style: TextStyle(fontSize: 18),),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return const EmptyCart();
                  }
                } else {
                  return const EmptyCart();
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Cart is Empty',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    ));
  }
}
