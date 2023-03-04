import 'package:ecommerc/features/main/data/services/products_services.dart';

import '../models/product.dart';

class ProductsRepo {
  final ProductsService service;

  ProductsRepo(this.service);

  Future<List<Product>> fetchProducts(int offset) async {
    final products = await service.fetchProducts(offset);
    return products.map((e) => Product.fromJson(e)).toList();
  }

  List<Product> searchProducts(List<Product> products, String searchString) {
    final returnedProducts = service.searchInProducts(products, searchString);
    return returnedProducts;
  }
  Future<void> deleteCart() async {
    await service.deleteCart();
  }
  Future<void> addProductToCart(Product product) async {
    await service.addProductToCart(product);
  }
  Future<void> deleteProductFromCart(Product product) async {
    await service.deleteProductFromCart(product);
  }
  Future<bool> isProductInCart(Product product) async {
    return await service.isProductInCart(product);
  }

  List<Product> convertDynamicToProducts(List<dynamic> dynamicProducts) {
    return service.convertDynamicToProducts(dynamicProducts);
  }
}
