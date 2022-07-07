part of 'credit_card_bloc.dart';

@freezed
class CreditCardEvent with _$CreditCardEvent {
  const factory CreditCardEvent.add({
    required String defaultCardNumber,
    required String defaultCardExpiryDate,
    required String defaultCardHolderName,
    required String defaultBankName,
    required CardType defaultCardType,
    required double defaultStartBalance,
  }) = _Add;

  const factory CreditCardEvent.edit({
    required int key,
  }) = _Edit;

  const factory CreditCardEvent.cardNumberChanged({
    required String newValue,
  }) = _CardNumberChanged;

  const factory CreditCardEvent.cardExpiryDateChanged({
    required String newValue,
  }) = _CardExpiryDateChanged;

  const factory CreditCardEvent.cardHolderNameChanged({
    required String newValue,
  }) = _CardHolderNameChanged;

  const factory CreditCardEvent.bankNameChanged({
    required String newValue,
  }) = _BankNameChanged;

  const factory CreditCardEvent.cardTypeChanged({
    required CardType newValue,
  }) = _CardTypeChanged;

  const factory CreditCardEvent.startBalanceChanged({
    required double newValue,
  }) = _StartBalanceChanged;

  const factory CreditCardEvent.creditChanged({
    required double newValue,
  }) = _CreditChanged;

  const factory CreditCardEvent.saveChanges() = _SaveChanges;
}