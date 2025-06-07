import 'package:flutter/material.dart';
import 'package:mark7/common/component/pagination_list_view.dart';
import 'package:mark7/restaurant/component/restaurant_card.dart';
import 'package:mark7/restaurant/provider/restaurant_provider.dart';
import 'package:mark7/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(context, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(
                  id: model.id,
                ),
              ),
            );
          },
          child: RestaurantCard.fromModel(model: model),
        );
      },
    );
  }
}
