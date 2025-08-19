import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../viewmodels/product_list_viewmodel.dart';

final productListProvider =
    StateNotifierProvider<ProductListViewModel, List<Product>>((ref) {
  return ProductListViewModel();
});
