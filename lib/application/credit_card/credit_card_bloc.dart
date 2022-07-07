import 'package:awesome_card/awesome_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/services/services.dart';
import 'package:greezy/presentation/shared/extensions/string_extensions.dart';

part 'credit_card_bloc.freezed.dart';
part 'credit_card_event.dart';
part 'credit_card_state.dart';

const _initialState = CreditCardState(usedCredit: 0);

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  final DataService _dataService;
  final LoggingService _loggingService;

  final CreditCardsBloc _creditCardsBloc;

  static int get maxCardNumberLength => 16;
  static int get maxCardExpiryDateLength => 5;
  static int get maxCardHolderNameLength => 30;
  static int get maxBankNameLength => 30;

  CreditCardBloc(this._dataService, this._loggingService, this._creditCardsBloc) : super(_initialState) {
    on<_Add>(_mapAddToState);
    on<_Edit>(_mapEditToState);
    on<_CardNumberChanged>(_mapCardNumberChangedToState);
    on<_CardExpiryDateChanged>(_mapCardExpiryDateChangedToState);
    on<_CardHolderNameChanged>(_mapCardHolderNameChangedToState);
    on<_BankNameChanged>(_mapBankNameChangedToState);
    on<_CardTypeChanged>(_mapCardTypeChangedToState);
    on<_StartBalanceChanged>(_mapStartBalanceChangedToState);
    on<_CreditChanged>(_mapCreditChangedToState);
    on<_SaveChanges>(_mapSaveChanges);
  }

  bool _isCardNumberValid(String value) => value.isValidLength(maxLength: maxCardNumberLength);

  bool _isCardExpiryDateValid(String value) => value.isValidLength(maxLength: maxCardExpiryDateLength);

  bool _isCardHolderNameValid(String value) => value.isValidLength(maxLength: maxCardHolderNameLength);

  bool _isBankNameValid(String value) => value.isValidLength(maxLength: maxBankNameLength);

  CreditCardState _buildAddState(
    String cardNumber,
    String cardExpiryDate,
    String cardHolderName,
    String bankName,
    CardType cardType,
    double startBalance,
  ) {
    return CreditCardState(
      cardNumber: cardNumber,
      cardExpiryDate: cardExpiryDate,
      cardHolderName: cardHolderName,
      bankName: bankName,
      cardType: cardType,
      startBalance: startBalance,
    );
  }

  CreditCardState _buildEditState(int key) {
    final item = _dataService.getCreditCard(key);
    CreditCardState state = const CreditCardState();
    return state.copyWith.call(
      key: item.key,
      usedCredit: item.usedCredit,
    );
  }

  Future<CreditCardState> _saveChanges() async {
    try {
      _saveCreditCard;
    } catch (e, s) {
      _loggingService.error(runtimeType, '_saveChanges: Unknown error while saving changes', e, s);
    }

    _creditCardsBloc.add(const CreditCardsEvent.init());

    return state;
  }

  Future<void> _saveCreditCard(_CreditCardState s) async {
    if (s.key != null) {
      await _dataService.updateCreditCard(s.key!, s.usedCredit);
      return;
    }
    await _dataService.saveCreditCard(
      s.cardNumber,
      s.cardExpiryDate,
      s.cardHolderName,
      s.bankName,
      s.cardType,
      s.startBalance,
      usedCredit: s.usedCredit,
    );
  }

  void _mapAddToState(_Add event, Emitter<CreditCardState> emit) {
    emit(_buildAddState(event.defaultCardNumber, event.defaultCardExpiryDate, event.defaultCardHolderName, event.defaultBankName, event.defaultCardType, event.defaultStartBalance));
  }
  
  void _mapEditToState(_Edit event, Emitter<CreditCardState> emit) {
    emit(_buildEditState(event.key));
  }

  void _mapCardNumberChangedToState(_CardNumberChanged event, Emitter<CreditCardState> emit) {
    final newState = state.copyWith.call(cardNumber: event.newValue, isCardNumberValid: _isCardNumberValid(event.newValue), isCardNumberDirty: true);
    emit(newState);
  }

  void _mapCardExpiryDateChangedToState(_CardExpiryDateChanged event, Emitter<CreditCardState> emit) {
    final newState = state.copyWith.call(cardExpiryDate: event.newValue, isCardExpiryDateValid: _isCardExpiryDateValid(event.newValue), isCardExpiryDateDirty: true);
    emit(newState);
  }

  void _mapCardHolderNameChangedToState(_CardHolderNameChanged event, Emitter<CreditCardState> emit) {
    final newState = state.copyWith.call(cardHolderName: event.newValue, isCardHolderNameValid: _isCardHolderNameValid(event.newValue), isCardHolderNameDirty: true);
    emit(newState);
  }

  void _mapBankNameChangedToState(_BankNameChanged event, Emitter<CreditCardState> emit) {
    final newState = state.copyWith.call(bankName: event.newValue, isBankNameValid: _isBankNameValid(event.newValue), isBankNameDirty: true);
    emit(newState);
  }

  void _mapCardTypeChangedToState(_CardTypeChanged event, Emitter<CreditCardState> emit) {
    final newState = state.copyWith.call(cardType: event.newValue);
    emit(newState);
  }

  void _mapStartBalanceChangedToState(_StartBalanceChanged event, Emitter<CreditCardState> emit) {
    final newState = state.copyWith.call(startBalance: event.newValue);
    emit(newState);
  }

  void _mapCreditChangedToState(_CreditChanged event, Emitter<CreditCardState> emit) {
    final newState = state.copyWith.call(usedCredit: event.newValue);
    emit(newState);
  }

  Future<void> _mapSaveChanges(_SaveChanges event, Emitter<CreditCardState> emit) async {
    final state = await _saveChanges();
    emit(state);
  }
}
