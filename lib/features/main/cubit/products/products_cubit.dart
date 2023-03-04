import 'package:ecommerc/features/main/cubit/products/products_state.dart';
import 'package:ecommerc/features/main/data/repo/products_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.repo) : super(ProductsInitial());
  int offset = 0;
  final ProductsRepo repo;
  List<Product> currentProducts = [];
  String lastSearch = '';
  void loadProducts() {
    if (state is ProductsLoading) return;
    final currentState = state;
    var oldProducts = <Product>[];
    if (currentState is ProductsLoaded) {
      oldProducts = currentState.products;
    }
    emit(ProductsLoading(oldProducts, isFirstFetch: offset == 0));

    repo.fetchProducts(offset).then((newProducts) {
      offset += 10;

      final products = (state as ProductsLoading).oldProducts;
      products.addAll(newProducts);
      currentProducts = products;
      emit(ProductsLoaded(currentProducts));
    });
  }
  List<Product> searchProducts(String searchString){
    lastSearch = searchString;
    final returnedProducts = repo.searchProducts(currentProducts, searchString);
    emit(ProductsLoaded(returnedProducts));
    return returnedProducts;
  }
}
