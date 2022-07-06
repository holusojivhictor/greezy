import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greezy/domain/enums/enums.dart';

part 'menu_card_model.freezed.dart';

@freezed
class MenuCardModel with _$MenuCardModel {
  factory MenuCardModel({
    required int id,
    required String title,
    required double price,
    required String image,
    required double rating,
    required int ratingCount,
    required List<MenuMealType> mealType,
    required List<MenuDishType> dishType,
  }) = _MenuCardModel;

  MenuCardModel._();
}