// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/domain/services/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:synchronized/synchronized.dart';

class DataServiceImpl implements DataService {
  final GreezyService _greezyService;

  late Box<InventoryItem> _inventoryBox;

  final _initLock = Lock();
  final _deleteAllLock = Lock();

  @override
  final StreamController<ItemType> mealAddedToInventory = StreamController.broadcast();

  @override
  final StreamController<ItemType> mealDeletedFromInventory = StreamController.broadcast();

  DataServiceImpl(this._greezyService);

  @override
  Future<void> init({String dir = 'greezy_data'}) async {
    await _initLock.synchronized(() async {
      await Hive.initFlutter(dir);
      _registerAdapters();
      _inventoryBox = await Hive.openBox<InventoryItem>('inventory');
    });
  }

  @override
  Future<void> deleteThemAll() async {
    await _deleteAllLock.synchronized(() async {
      await _inventoryBox.clear();
    });
  }

  @override
  Future<void> closeThemAll() async {
    await _deleteAllLock.synchronized(() async {
      await Hive.close();
    });

    await Future.wait([
      mealAddedToInventory.close(),
      mealDeletedFromInventory.close(),
    ]);
  }

  @override
  Future<void> addMealToInventory(int key, {bool raiseEvent = true}) async {
    if (isMealInInventory(key, ItemType.meal)) {
      return Future.value();
    }
    await _inventoryBox.add(InventoryItem(key, ItemType.meal.index));
    if (raiseEvent) {
      mealAddedToInventory.add(ItemType.meal);
    }
  }

  @override
  Future<void> deleteMealFromInventory(int key, {bool raiseEvent = true}) async {
    final item = _getItemFromInventory(key);

    if (item != null) {
      await _inventoryBox.delete(item.key);
    }

    if (raiseEvent) {
      mealDeletedFromInventory.add(ItemType.meal);
    }
  }

  @override
  Future<void> deleteMealsFromInventory({bool raiseEvent = true}) async {
    await deleteAllItemsInInventory();

    if (raiseEvent) {
      mealDeletedFromInventory.add(ItemType.meal);
    }
  }

  Future<void> deleteAllItemsInInventory() async {
    final toDeleteKeys = _inventoryBox.values.where((el) => el.type == ItemType.meal.index).map((e) => e.key).toList();
    if (toDeleteKeys.isNotEmpty) {
      await _inventoryBox.deleteAll(toDeleteKeys);
    }
  }

  @override
  List<MenuCardModel> getMenuInInventory() {
    final menu = _inventoryBox.values
        .where((el) => el.type == ItemType.meal.index)
        .map((e) => _greezyService.getMenuItemForCard(e.itemKey)).toList();

    return menu..sort((x, y) => x.title.compareTo(y.title));
  }

  InventoryItem? _getItemFromInventory(int key) {
    return _inventoryBox.values.firstWhereOrNull((el) => el.itemKey == key);
  }

  @override
  bool isMealInInventory(int key, ItemType type) {
    return _inventoryBox.values.any((el) => el.itemKey == key && el.type == type.index);
  }

  void _registerAdapters() {
    Hive.registerAdapter(InventoryItemAdapter());
  }
}