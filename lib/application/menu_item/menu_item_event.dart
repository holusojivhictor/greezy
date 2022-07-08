part of 'menu_item_bloc.dart';

@freezed
class MenuItemEvent with _$MenuItemEvent {
  const factory MenuItemEvent.loadFromId({required int key}) = _LoadProductFromKey;

  const factory MenuItemEvent.addToInventory({required int key}) = _AddToInventory;

  const factory MenuItemEvent.deleteFromInventory({required int key}) = _DeleteFromInventory;

  const factory MenuItemEvent.incrementQuantity() =_IncrementQuantity;

  const factory MenuItemEvent.decrementQuantity() =_DecrementQuantity;
}