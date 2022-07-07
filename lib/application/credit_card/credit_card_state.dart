part of 'credit_card_bloc.dart';

abstract class _CommonBaseState {
  double get usedCredit;

  String get cardNumber;

  String get cardExpiryDate;

  String get cardHolderName;

  String get bankName;

  bool get isCardNumberValid;

  bool get isCardNumberDirty;

  bool get isCardExpiryDateValid;

  bool get isCardExpiryDateDirty;

  bool get isCardHolderNameValid;

  bool get isCardHolderNameDirty;

  bool get isBankNameValid;

  bool get isBankNameDirty;

  CardType get cardType;

  double get startBalance;
}

@freezed
class CreditCardState with _$CreditCardState {
  @Implements<_CommonBaseState>()
  const factory CreditCardState({
    int? key,
    @Default(0) double usedCredit,
    @Default(CardType.masterCard) CardType cardType,
    @Default('') String cardNumber,
    @Default('') String cardExpiryDate,
    @Default('') String cardHolderName,
    @Default('') String bankName,
    @Default(false) bool isCardNumberValid,
    @Default(false) bool isCardNumberDirty,
    @Default(false) bool isCardExpiryDateValid,
    @Default(false) bool isCardExpiryDateDirty,
    @Default(false) bool isCardHolderNameValid,
    @Default(false) bool isCardHolderNameDirty,
    @Default(false) bool isBankNameValid,
    @Default(false) bool isBankNameDirty,
    @Default(100) double startBalance,
  }) = _CreditCardState;
}