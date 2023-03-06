import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerc/core/utils/utilities.dart';
import 'package:ecommerc/features/main/data/repo/products_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/models/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen(
      {Key? key, required this.productsRepo})
      : super(key: key);
  final ProductsRepo productsRepo;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int cartTotal = 0;

  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    products = widget.productsRepo
                        .convertDynamicToProducts(dynamicProducts);
                    calculateTotal();
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                          child: Text(
                            "My Cart",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              Product currentProduct = products[index];
                              return singleProductItem(currentProduct);
                            },
                            itemCount: products.length,
                          ),
                        ),
                        Text('Total: \$$cartTotal',
                            style: const TextStyle(
                              fontSize: 20,
                            )),

                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.productsRepo.updateHistory(products);
                                widget.productsRepo.deleteCart();
                                Utilities.showSnackBar(
                                    context, "Purchase Successful");
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              child: const Text(
                                "Purchase Items",
                                style: TextStyle(fontSize: 18),
                              ),
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

  Padding singleProductItem(Product currentProduct) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          leading: Image.network(
            currentProduct.thumbnail,
            height: 36,
          ),
          title: Text(
            currentProduct.title,
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            '\$ ${currentProduct.price}',
            style: const TextStyle(fontSize: 12),
          ),
          trailing: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                widget.productsRepo.deleteProductFromCart(currentProduct);
                cartTotal -= currentProduct.price;
              }),
        ),
      ),
    );
  }

  int calculateTotal() {
    cartTotal = 0;
    for (Product product in products) {
      cartTotal += product.price;
    }
    return cartTotal;
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
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
    ));
  }
}
