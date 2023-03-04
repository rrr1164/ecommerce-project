import '../../data/models/product.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  ProductsLoaded(this.products);
}

class ProductsLoading extends ProductsState {
  final List<Product> oldProducts;
  final bool isFirstFetch;

  ProductsLoading(this.oldProducts, {this.isFirstFetch = false});
}
