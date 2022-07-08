part of 'inventory_bloc.dart';

@freezed
class InventoryEvent with _$InventoryEvent {
  const factory InventoryEvent.init() = _Init;

  const factory InventoryEvent.addMeal({
    required int key,
  }) = _AddMeal;

  const factory InventoryEvent.deleteMeal({
    required int key,
  }) = _DeleteMeal;

  const factory InventoryEvent.clearMenu() = _ClearMenu;

  const factory InventoryEvent.refresh({required ItemType type}) = _Refresh;
}