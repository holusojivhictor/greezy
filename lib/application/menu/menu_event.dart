part of 'menu_bloc.dart';

@freezed
class MenuEvent with _$MenuEvent {
  const factory MenuEvent.init({
    @Default(<int>[]) List<int> excludeKeys,
  }) = _Init;

  const factory MenuEvent.searchChanged({
    required String search,
  }) = _SearchChanged;

  const factory MenuEvent.menuMealTypeChanged(MenuMealType? mealType) = _MenuMealTypeChanged;

  const factory MenuEvent.menuFilterTypeChanged(MenuFilterType filterType) = _MenuFilterTypeChanged;

  const factory MenuEvent.applyFilterChanges() = _ApplyFilterChanges;

  const factory MenuEvent.sortDirectionChanged(SortDirectionType sortDirectionType) = _SortDirectionTypeChanged;

  const factory MenuEvent.cancelChanges() = _CancelChanges;

  const factory MenuEvent.resetFilters() = _ResetFilters;
}