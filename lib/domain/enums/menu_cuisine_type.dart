import 'package:freezed_annotation/freezed_annotation.dart';

enum MenuCuisineType {
  american,
  asian,
  british,
  caribbean,
  @JsonValue('central europe')
  centralEurope,
  chinese,
  @JsonValue('eastern europe')
  easternEurope,
  french,
  indian,
  italian,
  japanese,
  kosher,
  mediterranean,
  mexican,
  @JsonValue('middle eastern')
  middleEastern,
  nordic,
  @JsonValue('south american')
  southAmerican,
  @JsonValue('south east asian')
  southEastAsian,
  korean,
  greek
}
