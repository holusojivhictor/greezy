part of 'menu_bloc.dart';

@freezed
class MenuState with _$MenuState {
  const factory MenuState.loading() = _LoadingState;

  const factory MenuState.loaded({
    required List<MenuCardModel> menu,
    String? search,
    required MenuFilterType menuFilterType,
    required MenuFilterType tempMenuFilterType,
    required SortDirectionType sortDirectionType,
    required SortDirectionType tempSortDirectionType,
    @Default(<int>[]) List<int> excludeKeys,
  }) = _LoadedState;
}