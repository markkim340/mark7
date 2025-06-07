import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark7/common/model/cursor_pagination_model.dart';
import 'package:mark7/common/provider/pagination_provider.dart';
import 'package:mark7/restaurant/model/restaurant_model.dart';
import 'package:mark7/restaurant/repository/restaurant_repository.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final restaurantState = ref.watch(restaurantProvider);

  if (restaurantState is! CursorPagination) {
    return null;
  }

  return restaurantState.data
      .firstWhereOrNull((restaurant) => restaurant.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);
  return notifier;
});

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({
    required super.repository,
  });

  void getDetail({required String id}) async {
    if (state is! CursorPagination) {
      await paginate();
    }

    // Exception handling
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;
    final resp = await repository.getRestaurantDetail(id: id);

    if (pState.data.where((el) => el.id == id).isEmpty) {
      // If the restaurant is not in the list, add it
      state = pState.copyWith(
        data: <RestaurantModel>[
          ...pState.data,
          resp,
        ],
      );
    } else {
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>(
              (el) => el.id == id ? resp : el,
            )
            .toList(),
      );
    }
  }
}
