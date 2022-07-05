part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _LoadingState;

  const factory HomeState.loaded({
    required List<MenuCardModel> featuredProducts,
    required List<MenuCardModel> popularProducts,
    required String displayName,
    required String timeParsed,
  }) = _LoadedState;
}
