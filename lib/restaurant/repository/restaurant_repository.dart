import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark7/common/const/data.dart';
import 'package:mark7/common/dio/dio.dart';
import 'package:mark7/common/model/cursor_pagination_model.dart';
import 'package:mark7/common/model/pagination_params.dart';
import 'package:mark7/restaurant/model/restaurant_detail_model.dart';
import 'package:mark7/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_repository.g.dart';

@Riverpod(keepAlive: true)
RestaurantRepository restaurantRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
}

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET('/')
  @Headers({'accessToken': true})
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{id}')
  @Headers({'accessToken': true})
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
