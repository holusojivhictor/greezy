import 'package:awesome_card/awesome_card.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_card_item.freezed.dart';

@freezed
class CreditCardItem with _$CreditCardItem {
  double get creditBalance => startBalance - usedCredit;

  factory CreditCardItem({
    required int key,
    required String itemKey,
    required String cardNumber,
    required String cardExpiryDate,
    required String cardHolderName,
    required String bankName,
    required CardType cardType,
    required DateTime createdAt,
    required double startBalance,
    @Default(0) double usedCredit,
  }) = _CreditCardItem;

  CreditCardItem._();
}