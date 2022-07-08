import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/domain/services/services.dart';

part 'inventory_bloc.freezed.dart';
part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final DataService _dataService;
  late final List<StreamSubscription> _streamSubscriptions;

  InventoryBloc(this._dataService) : super(const InventoryState.loaded(menu: [])) {
    _streamSubscriptions = [
      _dataService.mealAddedToInventory.stream.listen((type) => add(InventoryEvent.refresh(type: type))),
      _dataService.mealDeletedFromInventory.stream.listen((type) => add(InventoryEvent.refresh(type: type))),
    ];
    on<_Init>(_mapInitToState);
    on<_AddMeal>(_mapAddProductToState);
    on<_DeleteMeal>(_mapDeleteProductToState);
    on<_ClearMenu>(_mapClearAllProductsToState);
    on<_Refresh>(_mapRefreshToState);
  }

  @override
  Future<void> close() async {
    await Future.wait(_streamSubscriptions.map((e) => e.cancel()));
    await super.close();
  }

  void _mapInitToState(_Init event, Emitter<InventoryState> emit) {
    final menu = _dataService.getMenuInInventory();
    emit(InventoryState.loaded(menu: menu));
  }

  Future<void> _mapAddProductToState(_AddMeal event, Emitter<InventoryState> emit) async {
    await _dataService.addMealToInventory(event.key, raiseEvent: false);
    emit(_refreshItems(ItemType.meal));
  }

  Future<void> _mapDeleteProductToState(_DeleteMeal event, Emitter<InventoryState> emit) async {
    await _dataService.deleteMealFromInventory(event.key, raiseEvent: false);
    emit(_refreshItems(ItemType.meal));
  }

  Future<void> _mapClearAllProductsToState(_ClearMenu event, Emitter<InventoryState> emit) async {
    await _dataService.deleteMealsFromInventory(raiseEvent: false);
    emit(state.copyWith.call(menu: []));
  }

  void _mapRefreshToState(_Refresh event, Emitter<InventoryState> emit) {
    emit(_refreshItems(event.type));
  }

  InventoryState _refreshItems(ItemType type) {
    switch (type) {
      case ItemType.meal:
        return state.copyWith.call(menu: _dataService.getMenuInInventory());
    }
  }

  List<int> getItemsKeysToExclude() {
    return state.maybeMap(
      loaded: (state) => state.menu.map((e) => e.id).toList(),
      orElse: () => [],
    );
  }
}