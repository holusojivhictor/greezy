import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';

class CreditCardNumber extends StatefulWidget {
  final String cardNumber;
  const CreditCardNumber({Key? key, required this.cardNumber}) : super(key: key);

  @override
  State<CreditCardNumber> createState() => _CreditCardNumberState();
}

class _CreditCardNumberState extends State<CreditCardNumber> {
  late TextEditingController _cardNumberController;
  late String _cardNumber;

  @override
  void initState() {
    _cardNumber = widget.cardNumber;
    _cardNumberController = TextEditingController(text: _cardNumber);
    _cardNumberController.addListener(_cardNumberChanged);
    super.initState();
  }

  @override
  void dispose() {
    _cardNumberController.removeListener(_cardNumberChanged);
    _cardNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreditCardBloc, CreditCardState>(
      listener: (ctx, state) {
        if (state.cardNumber != _cardNumber) {
          setState(() {
            _cardNumber = state.cardNumber;
            _cardNumberController.text = _cardNumber;
          });
        }
      },
      builder: (ctx, state) => TextField(
        maxLength: CreditCardBloc.maxCardNumberLength,
        controller: _cardNumberController,
        keyboardType: TextInputType.number,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Card Number',
          alignLabelWithHint: true,
          labelText: 'Card Number',
        ),
      ),
    );
  }

  void _cardNumberChanged() {
    // Focusing the text field triggers text change, so we have to do this
    if (_cardNumber == _cardNumberController.text) {
      return;
    }
    _cardNumber = _cardNumberController.text;
    context.read<CreditCardBloc>().add(CreditCardEvent.cardNumberChanged(newValue: _cardNumberController.text));
  }
}