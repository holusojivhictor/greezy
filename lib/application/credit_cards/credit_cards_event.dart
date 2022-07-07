part of 'credit_cards_bloc.dart';

@freezed
class CreditCardsEvent with _$CreditCardsEvent {
  const factory CreditCardsEvent.init() = _Init;

  const factory CreditCardsEvent.delete({
    required int id,
  }) = _Delete;
}