import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark7/common/const/data.dart';
import 'package:mark7/common/dio/dio.dart';
import 'package:mark7/common/model/cursor_pagination_model.dart';
import 'package:mark7/common/model/pagination_params.dart';
import 'package:mark7/common/repository/base_pagination_repository.dart';
import 'package:mark7/rating/model/rating_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider =
    Provider.family<RestaurantRatingRepository, String>(
  (ref, rid) {
    final dio = ref.watch(dioProvider);
    return RestaurantRatingRepository(dio,
        baseUrl: 'http://$ip/restaurant/$rid/rating');
  },
);

// http://ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository
    implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @GET('/')
  @Headers({'accessToken': true})
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
