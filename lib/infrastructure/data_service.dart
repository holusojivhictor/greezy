// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:awesome_card/awesome_card.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:darq/darq.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/models/entities/credit_card/credit_card_base.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/domain/services/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:synchronized/synchronized.dart';

class DataServiceImpl implements DataService {
  final GreezyService _greezyService;

  late Box<InventoryItem> _inventoryBox;

  late Box<CreditCardHiveItem> _creditCardsBox;

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
      _creditCardsBox = await Hive.openBox<CreditCardHiveItem>('creditCards');
    });
  }

  @override
  Future<void> deleteThemAll() async {
    await _deleteAllLock.synchronized(() async {
      await _inventoryBox.clear();
      await _creditCardsBox.clear();
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

  @override
  List<CreditCardItem> getAllCreditCards() {
    final creditCards = _creditCardsBox.values.map((e) => _mapToCreditCardItem(e)).toList();
    return creditCards.orderBy((el) => el.createdAt).toList();
  }

  @override
  CreditCardItem getCreditCard(int key) {
    final item = _getCreditCard(key);
    return _mapToCreditCardItem(item);
  }

  @override
  Future<CreditCardItem> saveCreditCard(
    String cardNumber,
    String cardSecurityCode,
    String cardExpiryDate,
    String cardHolderName,
    String bankName,
    CardType cardType,
    double startBalance, {
    double usedCredit = 0,
  }) async {
    final now = DateTime.now();
    final creditCard = CreditCardHiveItem(
      createdAt: now,
      cardNumber: cardNumber.trim(),
      cardSecurityCode: cardSecurityCode.trim(),
      cardExpiryDate: cardExpiryDate.trim(),
      cardHolderName: cardHolderName.trim(),
      bankName: bankName.trim(),
      cardType: cardType.index,
      startBalance: startBalance,
      usedCredit: usedCredit,
    );
    final key = await _creditCardsBox.add(creditCard);
    return getCreditCard(key);
  }

  @override
  Future<void> deleteCreditCard(int key) {
    return _creditCardsBox.delete(key);
  }

  @override
  Future<CreditCardItem> updateCreditCard(int key, double usedCredit) async {
    final item = _creditCardsBox.values.firstWhere((el) => el.key == key);

    return _updateCreditCard(item, usedCredit);
  }

  T _getCreditCard<T extends CreditCardBase>(int key) {
    return _creditCardsBox.values.firstWhere((el) => el.key == key) as T;
  }

  CreditCardItem _mapToCreditCardItem(CreditCardBase e) {
    return _mapToCreditCardFromHiveItem(e as CreditCardHiveItem);
  }

  CreditCardItem _mapToCreditCardFromHiveItem(CreditCardHiveItem e) {
    return _mapToCreditCardItemFromBase(e);
  }

  CreditCardItem _mapToCreditCardItemFromBase(CreditCardBase e) {
    final cardType = CardType.values[e.cardType];
    final hiveObject = e as HiveObject;
    return CreditCardItem(
      key: hiveObject.key as int,
      createdAt: e.createdAt,
      cardNumber: e.cardNumber,
      cardSecurityCode: e.cardSecurityCode,
      cardExpiryDate: e.cardExpiryDate,
      cardHolderName: e.cardHolderName,
      bankName: e.bankName,
      cardType: cardType,
      startBalance: e.startBalance,
      usedCredit: e.usedCredit,
    );
  }

  Future<CreditCardItem> _updateCreditCard(CreditCardBase creditCard, double usedCredit) async {
    creditCard.usedCredit = creditCard.usedCredit + usedCredit;

    final hiveObject = creditCard as HiveObject;
    await hiveObject.save();
    return getCreditCard(hiveObject.key as int);
  }

  void _registerAdapters() {
    Hive.registerAdapter(InventoryItemAdapter());
    Hive.registerAdapter(CreditCardHiveItemAdapter());
  }
}