// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/domain/services/services.dart';

part 'credit_cards_bloc.freezed.dart';
part 'credit_cards_event.dart';
part 'credit_cards_state.dart';

const _initialState = CreditCardsState.initial(creditCards: []);

class CreditCardsBloc extends Bloc<CreditCardsEvent, CreditCardsState> {
  final DataService _dataService;

  _InitialState get currentState => state as _InitialState;

  CreditCardsBloc(this._dataService) : super(_initialState) {
   on<_Init>(_mapInitToState);
   on<_Delete>(_mapDeleteToState);
  }

  CreditCardsState _buildInitialState() {
    final creditCards = _dataService.getAllCreditCards();
    return CreditCardsState.initial(creditCards: creditCards);
  }

  void _mapInitToState(_Init event, Emitter<CreditCardsState> emit) {
    emit(_buildInitialState());
  }

  Future<void> _mapDeleteToState(_Delete event, Emitter<CreditCardsState> emit) async {
    await _dataService.deleteCreditCard(event.id);
    final creditCards = [...state.creditCards];
    creditCards.removeWhere((el) => el.key == event.id);
    final newState = state.copyWith.call(creditCards: creditCards);
    emit(newState);
  }
}