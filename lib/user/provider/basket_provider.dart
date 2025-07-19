import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mark7/user/model/basket_item_model.dart';

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  BasketProvider() : super([]);
}
