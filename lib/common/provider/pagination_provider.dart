import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark7/common/model/cursor_pagination_model.dart';
import 'package:mark7/common/model/model_with_id.dart';
import 'package:mark7/common/model/pagination_params.dart';
import 'package:mark7/common/repository/base_pagination_repository.dart';

class PaginationProvider<T extends IModelWithId,
        R extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final R repository;

  PaginationProvider({required this.repository})
      : super(CursorPaginationLoading()) {
    paginate(); // Initial fetch
  }

  Future<void> paginate({
    int fetchCount = 20,
    // Whether to fetch more data
    // true : fetch more data
    // false : fetch current data
    bool fetchMore = false,
    // Whether to force refresh the data
    bool forceRefresh = false,
  }) async {
    /// 1) If the current state is CursorPaginationLoading, loading data
    /// 2) If the current state is CursorPagination, fetch data
    /// 3) If the current state is CursorPaginationMore, fetch more data
    /// 4) If the current state is CursorPaginationError, fetch data error
    /// 5) If the current state is CursorPaginationRefresh, fetch initial data
    try {
      if (state is CursorPagination && !forceRefresh) {
        final pState = state as CursorPagination;
        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // create pagination params
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetch more data
      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchingMore(
          data: pState.data,
          meta: pState.meta,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }
      // initial fetch
      else {
        if (state is CursorPagination && !forceRefresh) {
          // If the current state is CursorPagination, we are refetching
          final pState = state as CursorPagination<T>;

          state = CursorPaginationRefetching<T>(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          // If the current state is not CursorPagination, we are loading
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;

        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e) {
      state = CursorPaginationError(message: e.toString());
      return;
    }
  }
}
