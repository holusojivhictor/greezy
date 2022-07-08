import 'dart:async';

import 'package:awesome_card/awesome_card.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/models/models.dart';

abstract class DataService {
  StreamController<ItemType> get mealAddedToInventory;

  StreamController<ItemType> get mealDeletedFromInventory;

  Future<void> init({String dir = 'greezy_data'});

  Future<void> deleteThemAll();

  Future<void> closeThemAll();

  List<MenuCardModel> getMenuInInventory();

  Future<void> addMealToInventory(int key, {bool raiseEvent = true});

  Future<void> deleteMealFromInventory(int key, {bool raiseEvent = true});

  Future<void> deleteMealsFromInventory({bool raiseEvent = true});

  bool isMealInInventory(int key, ItemType type);

  List<CreditCardItem> getAllCreditCards();

  CreditCardItem getCreditCard(int key);

  Future<CreditCardItem> saveCreditCard(
    String cardNumber,
    String cardSecurityCode,
    String cardExpiryDate,
    String cardHolderName,
    String bankName,
    CardType cardType,
    double startBalance, {
    double usedCredit = 0,
  });

  Future<void> deleteCreditCard(int key);

  Future<CreditCardItem> updateCreditCard(int key, double usedCredit);
}
