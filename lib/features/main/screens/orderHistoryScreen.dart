import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerc/features/main/data/repo/products_repo.dart';
import 'package:ecommerc/features/main/widgets/singleCartItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/models/product.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key, required this.productsRepo})
      : super(key: key);
  final ProductsRepo productsRepo;

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int orderCounter = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('history')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("carts")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.size != 0) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                List<dynamic> dynamicProducts = doc['cart'];
                List<Product> products = widget.productsRepo
                    .convertDynamicToProducts(dynamicProducts);
                orderCounter++;
                List<Widget> productsWidgets = <Widget>[];
                for (Product product in products) {
                  productsWidgets.add(
                      SingleHistoryItem(product: product));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Order # $orderCounter',style: const TextStyle(fontSize: 24),),
                    ),
                    Column(children: productsWidgets)
                  ],
                );
              });
        } else {
          return const Center(child: Text("No Order History",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),));
        }
      },
    );
  }
}

class SingleHistoryItem extends StatelessWidget {
  const SingleHistoryItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
    decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8)),
    child: ListTile(
      leading: Image.network(
        product.thumbnail,
        height: 36,
        width: 70,
      ),
      title: Text(
        product.title,
        maxLines: 1,
        style: const TextStyle(fontSize: 18,overflow: TextOverflow.ellipsis),
      ),
      subtitle: Text(
        '\$${product.price}',
        style: const TextStyle(fontSize: 12),
      ),
    ),
                    ),
                  );
  }
}
