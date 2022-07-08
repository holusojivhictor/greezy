import 'package:flutter/material.dart';
import 'package:greezy/presentation/payment/widgets/credit_card_bank_name.dart';
import 'package:greezy/presentation/payment/widgets/credit_card_expiry_code.dart';
import 'package:greezy/presentation/payment/widgets/credit_card_holder_name.dart';
import 'package:greezy/presentation/payment/widgets/credit_card_number.dart';

class CreditCardForm extends StatelessWidget {
  final bool isInEditMode;
  final String cardNumber;
  final String cardHolderName;
  final String bankName;
  final String expiryDate;
  final String securityCode;

  const CreditCardForm({
    Key? key,
    required this.isInEditMode,
    required this.cardNumber,
    required this.cardHolderName,
    required this.bankName,
    required this.expiryDate,
    required this.securityCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 15),
        CreditCardNumber(cardNumber: cardNumber),
        CreditCardExpiryCode(expiryDate: expiryDate, securityCode: securityCode),
        CreditCardHolderName(cardHolderName: cardHolderName),
        CreditCardBankName(bankName: bankName),
      ],
    );
  }
}