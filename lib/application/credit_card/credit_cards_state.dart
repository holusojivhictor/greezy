part of 'credit_cards_bloc.dart';

@freezed
class CreditCardsState with _$CreditCardsState {
  const factory CreditCardsState.initial({
    required List<CreditCardItem> creditCards,
  }) = _InitialState;
}