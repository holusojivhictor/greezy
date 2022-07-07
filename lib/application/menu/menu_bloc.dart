// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/domain/services/services.dart';

part 'menu_bloc.freezed.dart';
part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GreezyService _greezyService;

  _LoadedState get currentState => state as _LoadedState;

  MenuBloc(this._greezyService) : super(const MenuState.loading()) {
    on<_Init>(_mapInitToState);
    on<_SearchChanged>(_mapSearchChangedToState);
    on<_MenuMealTypeChanged>(_mapMealTypeChangedToState);
    on<_MenuFilterTypeChanged>(_mapFilterTypeChangedToState);
    on<_ApplyFilterChanges>(_mapApplyFilterChangesToState);
    on<_SortDirectionTypeChanged>(_mapSortDirectionChangedToState);
    on<_CancelChanges>(_mapCancelChangesToState);
    on<_ResetFilters>(_mapResetFiltersToState);
  }

  MenuState _buildInitialState({
    String? search,
    List<int> excludeKeys = const [],
    MenuMealType? mealType,
    MenuFilterType menuFilterType = MenuFilterType.rating,
    SortDirectionType sortDirectionType = SortDirectionType.asc,
  }) {
    final isLoaded = state is _LoadedState;
    var data = _greezyService.getMenuForCard();
    if (excludeKeys.isNotEmpty) {
      data = data.where((el) => !excludeKeys.contains(el.id)).toList();
    }

    if (!isLoaded) {
      _sortData(data, menuFilterType, sortDirectionType);
      return MenuState.loaded(
        menu: data,
        search: search,
        mealType: mealType,
        tempMealType: mealType,
        menuFilterType: menuFilterType,
        tempMenuFilterType: menuFilterType,
        sortDirectionType: sortDirectionType,
        tempSortDirectionType: sortDirectionType,
        excludeKeys: excludeKeys,
      );
    }

    if (search != null && search.isNotEmpty) {
      data = data.where((el) => el.title.toLowerCase().contains(search.toLowerCase())).toList();
    }

    switch (mealType) {
      case MenuMealType.breakfast:
        data = data.where((el) => el.mealType.contains(MenuMealType.breakfast)).toList();
        break;
      case MenuMealType.brunch:
        data = data.where((el) => el.mealType.contains(MenuMealType.brunch)).toList();
        break;
      case MenuMealType.lunch:
        data = data.where((el) => el.mealType.contains(MenuMealType.lunch)).toList();
        break;
      case MenuMealType.dinner:
        data = data.where((el) => el.mealType.contains(MenuMealType.dinner)).toList();
        break;
      case MenuMealType.snack:
        data = data.where((el) => el.mealType.contains(MenuMealType.snack)).toList();
        break;
      case MenuMealType.teatime:
        data = data.where((el) => el.mealType.contains(MenuMealType.teatime)).toList();
        break;
      default:
        break;
    }

    _sortData(data, menuFilterType, sortDirectionType);

    final s = currentState.copyWith.call(
      menu: data,
      search: search,
      mealType: mealType,
      tempMealType: mealType,
      menuFilterType: menuFilterType,
      tempMenuFilterType: menuFilterType,
      sortDirectionType: sortDirectionType,
      tempSortDirectionType: sortDirectionType,
      excludeKeys: excludeKeys,
    );

    return s;
  }

  void _sortData(List<MenuCardModel> data, MenuFilterType menuFilterType, SortDirectionType sortDirectionType) {
    switch (menuFilterType) {
      case MenuFilterType.price:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.price.compareTo(y.price));
        } else {
          data.sort((x, y) => y.price.compareTo(x.price));
        }
        break;
      case MenuFilterType.rating:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.rating.compareTo(y.rating));
        } else {
          data.sort((x, y) => y.rating.compareTo(x.rating));
        }
        break;
      case MenuFilterType.name:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.title.compareTo(y.title));
        } else {
          data.sort((x, y) => y.title.compareTo(x.title));
        }
        break;
      default:
        break;
    }
  }

  void _mapInitToState(_Init event, Emitter<MenuState> emit) {
    final state = _buildInitialState(excludeKeys: event.excludeKeys);
    emit(state);
  }

  void _mapSearchChangedToState(_SearchChanged event, Emitter<MenuState> emit) {
    final state = _buildInitialState(
      search: event.search,
      mealType: currentState.mealType,
      menuFilterType: currentState.menuFilterType,
      sortDirectionType: currentState.sortDirectionType,
      excludeKeys: currentState.excludeKeys,
    );
    emit(state);
  }

  void _mapMealTypeChangedToState(_MenuMealTypeChanged event, Emitter<MenuState> emit) {
    final state = currentState.copyWith.call(tempMealType: event.mealType);
    emit(state);
  }

  void _mapFilterTypeChangedToState(_MenuFilterTypeChanged event, Emitter<MenuState> emit) {
    final state = currentState.copyWith.call(tempMenuFilterType: event.filterType);
    emit(state);
  }

  void _mapApplyFilterChangesToState(_ApplyFilterChanges event, Emitter<MenuState> emit) {
    final state = _buildInitialState(
      search: currentState.search,
      mealType: currentState.tempMealType,
      menuFilterType: currentState.tempMenuFilterType,
      sortDirectionType: currentState.tempSortDirectionType,
      excludeKeys: currentState.excludeKeys,
    );
    emit(state);
  }

  void _mapSortDirectionChangedToState(_SortDirectionTypeChanged event, Emitter<MenuState> emit) {
    final state = currentState.copyWith.call(tempSortDirectionType: event.sortDirectionType);
    emit(state);
  }


  void _mapCancelChangesToState(_CancelChanges event, Emitter<MenuState> emit) {
    final state = currentState.copyWith.call(
      tempMealType: currentState.mealType,
      tempMenuFilterType: currentState.menuFilterType,
      tempSortDirectionType: currentState.sortDirectionType,
      excludeKeys: currentState.excludeKeys,
    );
    emit(state);
  }

  void _mapResetFiltersToState(_ResetFilters event, Emitter<MenuState> emit) {
    final resetState = _buildInitialState(
      excludeKeys: state.maybeMap(loaded: (state) => state.excludeKeys, orElse: () => []),
    );
    emit(resetState);
  }
}