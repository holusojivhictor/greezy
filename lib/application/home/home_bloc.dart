// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
  }

  HomeState _buildInitialState() {
    final isLoaded = state is _LoadedState;
    var featuredData = _greezyService.getFeaturedMenuForCard();
    var popularData = _greezyService.getPopularMenuForCard();
    final timeParsed = _greezyService.getParsedTime();
    final displayName = _greezyService.getUserName();

    if (!isLoaded) {
      return HomeState.loaded(
        featuredProducts: featuredData,
        popularProducts: popularData,
        timeParsed: timeParsed,
        displayName: displayName,
      );
    }

    final s = currentState.copyWith.call(
      featuredProducts: featuredData,
      popularProducts: popularData,
      timeParsed: timeParsed,
      displayName: displayName,
    );
    return s;
  }

  void _mapInitToState(_Init event, Emitter<HomeState> emit) {
    emit(_buildInitialState());
  }
}