import 'package:greezy/domain/models/entities/credit_card/credit_card_base.dart';
import 'package:hive/hive.dart';

part 'credit_card_hive_item.g.dart';

@HiveType(typeId: 2)
class CreditCardHiveItem extends HiveObject implements CreditCardBase {
  @override
  @HiveField(0)
  String itemKey;

  @override
  @HiveField(1)
  final DateTime createdAt;

  @override
  @HiveField(2)
  String cardNumber;

  @override
  @HiveField(3)
  String cardExpiryDate;

  @override
  @HiveField(4)
  String cardHolderName;

  @override
  @HiveField(5)
  String bankName;

  @override
  @HiveField(6)
  int cardType;

  @override
  @HiveField(7)
  double startBalance;

  @override
  @HiveField(8)
  double usedCredit;

  CreditCardHiveItem({
    required this.itemKey,
    required this.createdAt,
    required this.cardNumber,
    required this.cardExpiryDate,
    required this.cardHolderName,
    required this.bankName,
    required this.cardType,
    required this.startBalance,
    required this.usedCredit,
  });
}