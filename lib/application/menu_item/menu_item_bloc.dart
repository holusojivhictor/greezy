import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/domain/services/services.dart';

part 'menu_item_bloc.freezed.dart';
part 'menu_item_event.dart';
part 'menu_item_state.dart';

class MenuItemBloc extends Bloc<MenuItemEvent, MenuItemState> {
  final GreezyService _greezyService;
  final DataService _dataService;

  MenuItemBloc(this._greezyService, this._dataService) : super(const MenuItemState.loading()) {
    on<_LoadProductFromKey>(_mapLoadFromKeyToState);
    on<_AddToInventory>(_mapAddToInventoryToState);
    on<_DeleteFromInventory>(_mapDeleteFromInventoryToState);
    on<_IncrementQuantity>(_mapIncrementToState);
    on<_DecrementQuantity>(_mapDecrementToState);
  }

  MenuItemState _buildInitialState(MenuFileModel menuItem) {
    final isInInventory = _dataService.isMealInInventory(menuItem.id, ItemType.meal);

    return MenuItemState.loaded(
      id: menuItem.id,
      title: menuItem.title,
      price: menuItem.price,
      description: menuItem.description,
      cuisineType: menuItem.cuisineType,
      image: menuItem.image,
      rating: menuItem.rating.rate,
      ratingCount: menuItem.rating.count,
      healthLabels: menuItem.healthLabels,
      mealType: menuItem.mealType,
      dishType: menuItem.dishType,
      isInInventory: isInInventory,
      orderQuantity: 1,
    );
  }

  Future<void> _mapLoadFromKeyToState(_LoadProductFromKey event, Emitter<MenuItemState> emit) async {
    final menuItem = _greezyService.getMenuItem(event.key);
    emit(_buildInitialState(menuItem));
  }

  Future<void> _mapAddToInventoryToState(_AddToInventory event, Emitter<MenuItemState> emit) async {
    await state.map(
      loading: (state) async => emit(state),
      loaded: (state) async {
        await _dataService.addMealToInventory(event.key);
        emit(state.copyWith.call(isInInventory: true));
      },
    );
  }

  Future<void> _mapDeleteFromInventoryToState(_DeleteFromInventory event, Emitter<MenuItemState> emit) async {
    await state.map(
      loading: (state) async => emit(state),
      loaded: (state) async {
        await _dataService.deleteMealFromInventory(event.key);
        emit(state.copyWith.call(isInInventory: false));
      },
    );
  }

  void  _mapIncrementToState(_IncrementQuantity event, Emitter<MenuItemState> emit) {
    state.map(
      loading: (state) async => emit(state),
      loaded: (state) {
        emit(state.copyWith.call(orderQuantity: state.orderQuantity + 1));
      },
    );
  }

  void  _mapDecrementToState(_DecrementQuantity event, Emitter<MenuItemState> emit) {
    state.map(
      loading: (state) async => emit(state),
      loaded: (state) {
        emit(state.copyWith.call(orderQuantity: state.orderQuantity - 1));
      },
    );
  }
}