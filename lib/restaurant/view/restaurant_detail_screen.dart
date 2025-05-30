import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mark7/common/const/data.dart';
import 'package:mark7/common/layout/default_layout.dart';
import 'package:mark7/product/component/product_card.dart';
import 'package:mark7/restaurant/component/restaurant_card.dart';
import 'package:mark7/restaurant/model/restaurant_detail_model.dart';
import 'package:mark7/restaurant/repository/restaurant_repository.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  Future<RestaurantDetailModel> getRestaurantDetail() async {
    final dio = Dio();
    final repository = RestaurantRepository(
      dio,
      baseUrl: 'http://$ip/restaurant',
    );

    return repository.getRestaurantDetail(id: id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Restaurant Detail',
      child: FutureBuilder<RestaurantDetailModel>(
        future: getRestaurantDetail(),
        builder: (context, AsyncSnapshot<RestaurantDetailModel> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return CustomScrollView(
            slivers: [
              renderTop(snapshot.data!),
              renderLabel(),
              renderProduct(products: snapshot.data!.products),
            ],
          );
        },
      ),
    );
  }

  SliverToBoxAdapter renderTop(RestaurantDetailModel model) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
        detail: model.detail,
      ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Menu',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProduct({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(model: model),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
