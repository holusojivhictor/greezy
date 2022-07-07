import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/injection.dart';
import 'package:greezy/presentation/shared/bottom_sheets/common_bottom_sheet.dart';

const _cardNumberKey = 'cardNumber';
const _cardExpiryDateKey = 'cardExpiryDate';
const _cardHolderNameKey = 'cardHolderName';
const _bankNameKey = 'bankName';
const _cardTypeKey = 'cardType';
const _startBalanceKey = 'startBalance';
const _itemKey = 'key';
const _isInEditModeKey = 'isInEditMode';
const _usedCreditKey = 'usedCredit';

class AddCardBottomSheet extends StatelessWidget {
  const AddCardBottomSheet({Key? key}) : super(key: key);

  static Map<String, dynamic> buildCreditCardArgsForAdd(String cardNumber, String cardExpiryDate, String cardHolderName, String bankName, CardType cardType, double startBalance,) =>
      <String, dynamic>{
        _isInEditModeKey: false,
        _cardNumberKey: cardNumber,
        _cardExpiryDateKey: cardExpiryDate,
        _cardHolderNameKey: cardHolderName,
        _bankNameKey: bankName,
        _cardTypeKey: cardType,
        _startBalanceKey: startBalance,
      };

  static Map<String, dynamic> buildCreditCardArgsForEdit(int key, double usedCredit) =>
      <String, dynamic>{_isInEditModeKey: true, _itemKey: key, _usedCreditKey: usedCredit};

  static Widget getWidgetFromArgs(BuildContext context, Map<String, dynamic> args) {
    assert(args.isNotEmpty);
    final isInEditMode = args[_isInEditModeKey] as bool;
    final event = isInEditMode ? CreditCardEvent.add(
        defaultCardNumber: args[_cardNumberKey] as String,
        defaultCardExpiryDate: args[_cardExpiryDateKey] as String,
        defaultCardHolderName: args[_cardHolderNameKey] as String,
        defaultBankName: args[_bankNameKey] as String,
        defaultCardType: args[_cardTypeKey] as CardType,
        defaultStartBalance: args[_startBalanceKey] as double) : CreditCardEvent.edit(key: args[_itemKey] as int);
    return BlocProvider<CreditCardBloc>(
      create: (ctx) => Injection.getCreditCardBloc(context.read<CreditCardsBloc>())..add(event),
      child: const AddCardBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      builder: (ctx, state) => CommonBottomSheet(
        titleIcon: Icons.add,
        title: 'Create new card',
        onOk: !state.isCardNumberValid || !state.isCardExpiryDateValid || !state.isCardHolderNameValid || !state.isBankNameValid
            ? null : () => _saveChanges(context),
        onCancel: () => Navigator.pop(context),
        child: Container(),
      ),
    );
  }

  void _saveChanges(BuildContext context) {
    context.read<CreditCardBloc>().add(const CreditCardEvent.saveChanges());
    Navigator.pop(context);
  }
}
