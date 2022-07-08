import 'package:greezy/domain/models/models.dart' as models;
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';

class CreditCardListTile extends StatelessWidget {
  final int itemKey;
  final String cardNumber;
  final String cardSecurityCode;
  final String cardExpiryDate;
  final String cardHolderName;
  final String bankName;

  CreditCardListTile({
    Key? key,
    required models.CreditCardItem item,
  })  : itemKey = item.key,
        cardNumber = item.cardNumber,
        cardSecurityCode = item.cardSecurityCode,
        cardExpiryDate = item.cardExpiryDate,
        cardHolderName = item.cardHolderName,
        bankName = item.bankName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreditCard(
      cardNumber: cardNumber,
      cardExpiry: cardExpiryDate,
      cardHolderName: cardHolderName,
      cvv: cardSecurityCode,
      bankName: bankName,
      cardType: CardType.masterCard,
      showBackSide: false,
      frontBackground: CardBackgrounds.black,
      backBackground: CardBackgrounds.white,
      showShadow: true,
      textExpDate: 'Exp. Date',
      textName: 'Name',
      textExpiry: 'MM/YY',
    );
  }
}
