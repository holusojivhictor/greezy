import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/injection.dart';
import 'package:greezy/presentation/payment/widgets/credit_card_form.dart';
import 'package:greezy/presentation/shared/bottom_sheets/common_bottom_sheet.dart';
import 'package:greezy/presentation/shared/utils/toast_utils.dart';

const _cardNumberKey = 'cardNumber';
const _cardSecurityCodeKey = 'cardSecurityCode';
const _cardExpiryDateKey = 'cardExpiryDate';
const _cardHolderNameKey = 'cardHolderName';
const _bankNameKey = 'bankName';
const _cardTypeKey = 'cardType';
const _startBalanceKey = 'startBalance';
const _itemKey = 'key';
const _isInEditModeKey = 'isInEditMode';
const _usedCreditKey = 'usedCredit';

class AddCardBottomSheet extends StatelessWidget {
  final bool isInEditMode;
  const AddCardBottomSheet({Key? key, required this.isInEditMode}) : super(key: key);

  static Map<String, dynamic> buildCreditCardArgsForAdd(String cardNumber, String cardSecurityCode, String cardExpiryDate, String cardHolderName, String bankName, CardType cardType, double startBalance,) =>
      <String, dynamic>{
        _isInEditModeKey: false,
        _cardNumberKey: cardNumber,
        _cardSecurityCodeKey: cardSecurityCode,
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
    final event = isInEditMode ? CreditCardEvent.edit(key: args[_itemKey] as int) : CreditCardEvent.add(
        defaultCardNumber: args[_cardNumberKey] as String,
        defaultCardSecurityCode: args[_cardSecurityCodeKey] as String,
        defaultCardExpiryDate: args[_cardExpiryDateKey] as String,
        defaultCardHolderName: args[_cardHolderNameKey] as String,
        defaultBankName: args[_bankNameKey] as String,
        defaultCardType: args[_cardTypeKey] as CardType,
        defaultStartBalance: args[_startBalanceKey] as double);
    return BlocProvider<CreditCardBloc>(
      create: (ctx) => Injection.getCreditCardBloc(context.read<CreditCardsBloc>())..add(event),
      child: AddCardBottomSheet(isInEditMode: isInEditMode),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      builder: (ctx, state) => CommonBottomSheet(
        titleIcon: Icons.add,
        title: 'Create new card',
        onOk: !state.isCardNumberValid || !state.isCardSecurityCodeValid || !state.isCardExpiryDateValid || !state.isCardHolderNameValid || !state.isBankNameValid
            ? null : () => _saveChanges(context),
        onCancel: () => Navigator.pop(context),
        child: _FormWidget(isInEditMode: isInEditMode),
      ),
    );
  }

  void _saveChanges(BuildContext context) {
    final fToast = ToastUtils.of(context);
    context.read<CreditCardBloc>().add(const CreditCardEvent.saveChanges());
    ToastUtils.showSucceedToast(fToast, 'Successfully created credit card!');
    Navigator.pop(context);
  }
}

class _FormWidget extends StatelessWidget {
  final bool isInEditMode;
  const _FormWidget({Key? key, required this.isInEditMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      builder: (ctx, state) => CreditCardForm(
        isInEditMode: isInEditMode,
        cardNumber: state.cardNumber,
        cardHolderName: state.cardHolderName,
        bankName: state.bankName,
        expiryDate: state.cardExpiryDate,
        securityCode: state.cardSecurityCode,
        startBalance: state.startBalance,
      ),
    );
  }
}
