import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';

class CreditCardExpiryCode extends StatefulWidget {
  final String expiryDate;
  final String securityCode;

  const CreditCardExpiryCode({
    Key? key,
    required this.expiryDate,
    required this.securityCode,
  }) : super(key: key);

  @override
  State<CreditCardExpiryCode> createState() => _CreditCardExpiryCodeState();
}

class _CreditCardExpiryCodeState extends State<CreditCardExpiryCode> {
  late TextEditingController _expiryDateController;
  late TextEditingController _securityCodeController;

  late String _expiryDate;
  late String _securityCode;

  @override
  void initState() {
    _expiryDate = widget.expiryDate;
    _securityCode = widget.securityCode;

    _expiryDateController = TextEditingController(text: _expiryDate);
    _securityCodeController = TextEditingController(text: _securityCode);

    _expiryDateController.addListener(_expiryDateChanged);
    _securityCodeController.addListener(_securityCodeChanged);
    super.initState();
  }

  @override
  void dispose() {
    _expiryDateController.removeListener(_expiryDateChanged);
    _securityCodeController.removeListener(_securityCodeChanged);
    _expiryDateController.dispose();
    _securityCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 45,
          fit: FlexFit.tight,
          child: BlocConsumer<CreditCardBloc, CreditCardState>(
            listener: (ctx, state) {
              if (state.cardExpiryDate != _expiryDate || state.cardSecurityCode != _securityCode) {
                setState(() {
                  _expiryDate = state.cardExpiryDate;
                  _expiryDateController.text = _expiryDate;
                });
              }
            },
            builder: (ctx, state) => TextField(
              controller: _expiryDateController,
              maxLength: CreditCardBloc.maxCardExpiryDateLength,
              keyboardType: TextInputType.text,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: 'Expiry Date',
                alignLabelWithHint: true,
                labelText: 'Expiry Date',
                errorText: !state.isCardExpiryDateValid && state.isCardExpiryDateDirty ? 'Invalid value' : null,
              ),
            ),
          ),
        ),
        const Spacer(flex: 10),
        Flexible(
          flex: 45,
          fit: FlexFit.tight,
          child: BlocConsumer<CreditCardBloc, CreditCardState>(
            listener: (ctx, state) {
              if (state.cardSecurityCode != _securityCode) {
                setState(() {
                  _securityCode = state.cardSecurityCode;
                  _securityCodeController.text = _securityCode;
                });
              }
            },
            builder: (ctx, state) => TextField(
              controller: _securityCodeController,
              maxLength: CreditCardBloc.maxCardSecurityCodeLength,
              keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: 'CVV',
                alignLabelWithHint: true,
                labelText: 'CVV',
                errorText: !state.isCardSecurityCodeValid && state.isCardSecurityCodeDirty ? 'Invalid value' : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _expiryDateChanged() {
    // Focusing the text field triggers text change, so we have to do this
    if (_expiryDate == _expiryDateController.text) {
      return;
    }
    _expiryDate = _expiryDateController.text;
    context.read<CreditCardBloc>().add(CreditCardEvent.cardExpiryDateChanged(newValue: _expiryDateController.text));
  }

  void _securityCodeChanged() {
    // Focusing the text field triggers text change, so we have to do this
    if (_securityCode == _securityCodeController.text) {
      return;
    }
    _securityCode = _securityCodeController.text;
    context.read<CreditCardBloc>().add(CreditCardEvent.cardSecurityCodeChanged(newValue: _securityCodeController.text));
  }
}
