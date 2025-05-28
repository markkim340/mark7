import 'package:flutter/material.dart';
import 'package:mark7/common/layout/default_layout.dart';
import 'package:mark7/product/component/product_card.dart';
import 'package:mark7/restaurant/component/restaurant_card.dart';
import 'package:mark7/restaurant/model/restaurant_model.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final RestaurantModel model;

  const RestaurantDetailScreen({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Restaurant Detail',
      child: CustomScrollView(
        slivers: [
          renderTop(),
          renderLabel(),
          renderProduct(),
        ],
      ),
    );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
        detail: '맛잇네 ㅋ',
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

  SliverPadding renderProduct() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard(id: model.id),
            );
          },
          childCount: 10, // 예시로 10개의 상품을 표시
        ),
      ),
    );
  }
}
