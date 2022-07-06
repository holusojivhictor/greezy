import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greezy/domain/enums/enums.dart';

part 'menu_file_model.freezed.dart';
part 'menu_file_model.g.dart';

@freezed
class MenuFileModel with _$MenuFileModel {
  factory MenuFileModel({
    required int id,
    required String title,
    required double price,
    required String description,
    required MenuCuisineType cuisineType,
    required String image,
    required RatingModel rating,
    required List<String> healthLabels,
    required List<MenuMealType> mealType,
    required List<MenuDishType> dishType,
  }) = _MenuFileModel;

  MenuFileModel._();

  factory MenuFileModel.fromJson(Map<String, dynamic> json) => _$MenuFileModelFromJson(json);
}

@freezed
class RatingModel with _$RatingModel {
  factory RatingModel({
    required double rate,
    required int count,
  }) = _RatingModel;

  RatingModel._();

  factory RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json);
}