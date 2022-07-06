part of 'menu_item_bloc.dart';

@freezed
class MenuItemState with _$MenuItemState {
  const factory MenuItemState.loading() = _LoadingState;

  const factory MenuItemState.loaded({
    required int id,
    required String title,
    required double price,
    required String description,
    required MenuCuisineType cuisineType,
    required String image,
    required double rating,
    required int ratingCount,
    required List<String> healthLabels,
    required List<MenuMealType> mealType,
    required List<MenuDishType> dishType,
    required bool isInInventory,
  }) = _LoadedState;
}