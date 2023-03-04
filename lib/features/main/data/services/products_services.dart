import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

import '../models/product.dart';

class ProductsService {
  static const FETCH_LIMIT = 10;
  final baseUrl = "https://dummyjson.com/products/";

  Future<List<dynamic>> fetchProducts(int offset) async {
    try {
      String url = "$baseUrl?limit=$FETCH_LIMIT&skip=$offset";
      final response = await get(Uri.parse(url));
      print("loading: $url");
      return jsonDecode(response.body)["products"] as List<dynamic>;
    } catch (err) {
      print("error fetching data");
      return [];
    }
  }

  List<Product> searchInProducts(List<Product> products, String searchString) {
    List<Product> returnedProducts = [];
    for (Product product in products) {
      if (product.title.toLowerCase().contains(searchString.toLowerCase())) {
        returnedProducts.add(product);
      }
    }
    return returnedProducts;
  }

  Future<void> addProductToCart(Product product) async {
    await FirebaseFirestore.instance
        .collection("carts")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      "cart": FieldValue.arrayUnion([product.toJson()]),
    }, SetOptions(merge: true));
  }

  Future<bool> isProductInCart(Product currentProduct) async {
    bool inCart = false;
    await FirebaseFirestore.instance
        .collection("carts")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((doc) {
      if (doc.data()?["cart"] != null) {
        List<dynamic> allProducts = doc.data()!["cart"];
        for (Map<String, dynamic> map in allProducts) {
          Product product = Product.fromJson(map);
          if (product.title
              .toLowerCase()
              .contains(currentProduct.title.toLowerCase())) {
            inCart = true;
          }
        }
      }
    });
    return inCart;
  }
  List<Product> convertDynamicToProducts(List<dynamic> dynamicProducts){
    List<Product> products = [];
    for(Map<String,dynamic> map in dynamicProducts){
      Product product = Product.fromJson(map);
      products.add(product);
    }
    return products;
  }
  Future<void> deleteProductFromCart(Product product) async {

    FirebaseFirestore.instance.collection("carts").doc(FirebaseAuth.instance.currentUser?.uid).update({
      "cart":FieldValue.arrayRemove([product.toJson()]) });
  }
  Future<void> deleteCart() async {
    final collection = FirebaseFirestore.instance.collection('carts');
    collection
        .doc(FirebaseAuth.instance.currentUser?.uid) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .then((_) => print('Deleted cart'))
        .catchError((error) => print('Delete failed: $error'));
  }
}
