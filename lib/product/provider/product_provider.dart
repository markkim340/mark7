import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark7/common/model/cursor_pagination_model.dart';
import 'package:mark7/common/provider/pagination_provider.dart';
import 'package:mark7/product/model/product_model.dart';
import 'package:mark7/product/repository/product_repository.dart';

final productProvider =
    StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(productRepositoryProvider);

  return ProductStateNotifier(repository: repository);
});

class ProductStateNotifier
    extends PaginationProvider<ProductModel, ProductRepository> {
  ProductStateNotifier({
    required super.repository,
  });
}
