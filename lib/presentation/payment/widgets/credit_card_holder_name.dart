import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';

class CreditCardHolderName extends StatefulWidget {
  final String cardHolderName;
  const CreditCardHolderName({Key? key, required this.cardHolderName}) : super(key: key);

  @override
  State<CreditCardHolderName> createState() => _CreditCardHolderNameState();
}

class _CreditCardHolderNameState extends State<CreditCardHolderName> {
  late TextEditingController _cardHolderNameController;
  late String _cardHolderName;

  @override
  void initState() {
    _cardHolderName = widget.cardHolderName;
    _cardHolderNameController = TextEditingController(text: _cardHolderName);
    _cardHolderNameController.addListener(_cardHolderNameChanged);
    super.initState();
  }

  @override
  void dispose() {
    _cardHolderNameController.removeListener(_cardHolderNameChanged);
    _cardHolderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreditCardBloc, CreditCardState>(
      listener: (ctx, state) {
        if (state.cardHolderName != _cardHolderName) {
          setState(() {
            _cardHolderName = state.cardHolderName;
            _cardHolderNameController.text = _cardHolderName;
          });
        }
      },
      builder: (ctx, state) => TextField(
        maxLength: CreditCardBloc.maxCardHolderNameLength,
        controller: _cardHolderNameController,
        keyboardType: TextInputType.text,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Holder Name',
          alignLabelWithHint: true,
          labelText: 'Holder Name',
        ),
      ),
    );
  }

  void _cardHolderNameChanged() {
    // Focusing the text field triggers text change, so we have to do this
    if (_cardHolderName == _cardHolderNameController.text) {
      return;
    }
    _cardHolderName = _cardHolderNameController.text;
    context.read<CreditCardBloc>().add(CreditCardEvent.cardHolderNameChanged(newValue: _cardHolderNameController.text));
  }
}