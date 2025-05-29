import 'package:mark7/common/const/data.dart';
import 'package:mark7/restaurant/model/restaurant_model.dart';

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson({required Map<String, dynamic> json}) {
    return RestaurantDetailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List<String>.from(json['tags'] as List),
      priceRange: RestaurantPriceRange.values.firstWhere(
        (e) => e.toString() == 'RestaurantPriceRange.${json['priceRange']}',
        orElse: () => RestaurantPriceRange.medium,
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'] as String,
      products: (json['products'] as List)
          .map<RestaurantProductModel>(
            (item) => RestaurantProductModel.fromJson(json: item),
          )
          .toList(),
    );
  }
}

class RestaurantProductModel {
  final String id;
  final String name;
  final String detail;
  final String imgUrl;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory RestaurantProductModel.fromJson(
      {required Map<String, dynamic> json}) {
    return RestaurantProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      detail: json['detail'] as String,
      imgUrl: 'http://$ip${json['imgUrl']}',
      price: json['price'] as int,
    );
  }
}
