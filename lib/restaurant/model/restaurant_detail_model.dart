import 'package:json_annotation/json_annotation.dart';
import 'package:mark7/common/utils/data_utils.dart';
import 'package:mark7/restaurant/model/restaurant_model.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable()
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

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantDetailModelToJson(this);
}

@JsonSerializable()
class RestaurantProductModel {
  final String id;
  final String name;
  final String detail;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String imgUrl;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantProductModelToJson(this);
}
