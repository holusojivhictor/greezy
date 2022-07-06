// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/domain/services/services.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GreezyService _greezyService;

  _LoadedState get currentState => state as _LoadedState;

  HomeBloc(this._greezyService) : super(const HomeState.loading()) {
    on<_Init>(_mapInitToState);
    on<_SearchChanged>(_mapSearchChangedToState);
    on<_MenuMealTypeChanged>(_mapMealTypeChanged);
    on<_ApplyFilterChanges>(_mapApplyFilterChangesToState);
  }

  HomeState _buildInitialState({
    String? search,
    MenuMealType? mealType,
  }) {
    final isLoaded = state is _LoadedState;
    var featuredData = _greezyService.getFeaturedMenuForCard();
    var popularData = _greezyService.getPopularMenuForCard();
    final timeParsed = _greezyService.getParsedTime();
    final displayName = _greezyService.getUserName();

    if (!isLoaded) {
      return HomeState.loaded(
        search: search,
        featuredMenu: featuredData,
        popularMenu: popularData,
        timeParsed: timeParsed,
        displayName: displayName,
        mealType: mealType,
        tempMealType: mealType,
      );
    }

    if (search != null && search.isNotEmpty) {
      featuredData = featuredData.where((el) => el.title.toLowerCase().contains(search.toLowerCase())).toList();
      popularData = popularData.where((el) => el.title.toLowerCase().contains(search.toLowerCase())).toList();
    }

    switch (mealType) {
      case MenuMealType.breakfast:
        featuredData = featuredData.where((el) => el.mealType.contains(MenuMealType.breakfast)).toList();
        popularData = popularData.where((el) => el.mealType.contains(MenuMealType.breakfast)).toList();
        break;
      case MenuMealType.brunch:
        featuredData = featuredData.where((el) => el.mealType.contains(MenuMealType.brunch)).toList();
        popularData = popularData.where((el) => el.mealType.contains(MenuMealType.brunch)).toList();
        break;
      case MenuMealType.lunch:
        featuredData = featuredData.where((el) => el.mealType.contains(MenuMealType.lunch)).toList();
        popularData = popularData.where((el) => el.mealType.contains(MenuMealType.lunch)).toList();
        break;
      case MenuMealType.dinner:
        featuredData = featuredData.where((el) => el.mealType.contains(MenuMealType.dinner)).toList();
        popularData = popularData.where((el) => el.mealType.contains(MenuMealType.dinner)).toList();
        break;
      case MenuMealType.snack:
        featuredData = featuredData.where((el) => el.mealType.contains(MenuMealType.snack)).toList();
        popularData = popularData.where((el) => el.mealType.contains(MenuMealType.snack)).toList();
        break;
      case MenuMealType.teatime:
        featuredData = featuredData.where((el) => el.mealType.contains(MenuMealType.teatime)).toList();
        popularData = popularData.where((el) => el.mealType.contains(MenuMealType.teatime)).toList();
        break;
      default:
        break;
    }

    final s = currentState.copyWith.call(
      search: search,
      featuredMenu: featuredData,
      popularMenu: popularData,
      timeParsed: timeParsed,
      displayName: displayName,
      mealType: mealType,
      tempMealType: mealType,
    );
    return s;
  }

  void _mapInitToState(_Init event, Emitter<HomeState> emit) {
    emit(_buildInitialState());
  }

  void _mapSearchChangedToState(_SearchChanged event, Emitter<HomeState> emit) {
    final state = _buildInitialState(search: event.search, mealType: currentState.mealType);
    emit(state);
  }

  void _mapMealTypeChanged(_MenuMealTypeChanged event, Emitter<HomeState> emit) {
    final state = currentState.copyWith.call(tempMealType: event.mealType);
    emit(state);
  }

  void _mapApplyFilterChangesToState(_ApplyFilterChanges event, Emitter<HomeState> emit) {
    final state = _buildInitialState(search: currentState.search, mealType: currentState.tempMealType);
    emit(state);
  }
}