import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:mark7/common/layout/default_layout.dart';
import 'package:mark7/common/model/cursor_pagination_model.dart';
import 'package:mark7/product/component/product_card.dart';
import 'package:mark7/rating/component/rating_card.dart';
import 'package:mark7/rating/model/rating_model.dart';
import 'package:mark7/restaurant/component/restaurant_card.dart';
import 'package:mark7/restaurant/model/restaurant_detail_model.dart';
import 'package:mark7/restaurant/model/restaurant_model.dart';
import 'package:mark7/restaurant/provider/restaurant_provider.dart';
import 'package:mark7/restaurant/provider/restaurant_rating_provider.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the restaurant detail when the screen is initialized
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(widget.id));

    if (state == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: 'Restaurant Detail',
      child: CustomScrollView(
        slivers: [
          renderTop(state),
          if (state is! RestaurantDetailModel) renderLoading(),
          if (state is RestaurantDetailModel) ...[
            renderLabel(),
            renderProduct(products: state.products),
          ],
          if (ratingsState is CursorPagination<RatingModel>)
            renderRatings(models: ratingsState.data),
        ],
      ),
    );
  }

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RatingCard.fromModel(
              model: models[index],
            ),
          ),
          childCount: models.length,
        ),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                  padding: EdgeInsets.zero,
                  lines: 6,
                  spacing: 6.0,
                  lineStyle: SkeletonLineStyle(
                    height: 12.0,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ),
            ...List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 22.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 90.0,
                        height: 90.0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: SkeletonParagraph(
                        style: const SkeletonParagraphStyle(
                          padding: EdgeInsets.zero,
                          lines: 5,
                          spacing: 6.0,
                          lineStyle: SkeletonLineStyle(
                            height: 13.0,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop(RestaurantModel model) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
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
