part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _LoadingState;

  const factory HomeState.loaded({
    required List<MenuCardModel> featuredMenu,
    required List<MenuCardModel> popularMenu,
    required String displayName,
    required String timeParsed,
    String? search,
    MenuMealType? mealType,
    MenuMealType? tempMealType,
  }) = _LoadedState;
}
