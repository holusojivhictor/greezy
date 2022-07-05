import 'package:freezed_annotation/freezed_annotation.dart';

enum MenuDishType {
  @JsonValue('biscuits and cookies')
  biscuitsAndCookies,
  bread,
  cereals,
  @JsonValue('condiments and sauces')
  condimentsAndSauces,
  desserts,
  drinks,
  @JsonValue('main course')
  mainCourse,
  pancake,
  preps,
  preserve,
  salad,
  sandwiches,
  @JsonValue('side dish')
  sideDish,
  soup,
  starter,
  sweets,
  egg,
  christmas,
  @JsonValue('special occasions') specialOccasions,
}