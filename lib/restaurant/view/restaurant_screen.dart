import 'package:flutter/material.dart';
import 'package:mark7/restaurant/component/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RestaurantCard(
            image: Image.asset(
              'asset/img/misc/sample.jpg',
              fit: BoxFit.cover,
            ),
            name: 'Team Days',
            tags: ['bring', 'Bitcoin', 'Dart'],
            ratingCount: 410,
            deliveryTime: 30,
            deliveryFee: 0,
            rating: 3.21,
          ),
        ),
      ),
    );
  }
}
