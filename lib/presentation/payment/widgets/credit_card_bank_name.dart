import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';

class CreditCardBankName extends StatefulWidget {
  final String bankName;
  const CreditCardBankName({Key? key, required this.bankName}) : super(key: key);

  @override
  State<CreditCardBankName> createState() => _CreditCardBankNameState();
}

class _CreditCardBankNameState extends State<CreditCardBankName> {
  late TextEditingController _bankNameController;
  late String _bankName;

  @override
  void initState() {
    _bankName = widget.bankName;
    _bankNameController = TextEditingController(text: _bankName);
    _bankNameController.addListener(_bankNameChanged);
    super.initState();
  }

  @override
  void dispose() {
    _bankNameController.removeListener(_bankNameChanged);
    _bankNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreditCardBloc, CreditCardState>(
      listener: (ctx, state) {
        if (state.bankName != _bankName) {
          setState(() {
            _bankName = state.bankName;
            _bankNameController.text = _bankName;
          });
        }
      },
      builder: (ctx, state) => TextField(
        maxLength: CreditCardBloc.maxBankNameLength,
        controller: _bankNameController,
        keyboardType: TextInputType.text,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Bank Name',
          alignLabelWithHint: true,
          labelText: 'Bank Name',
        ),
      ),
    );
  }

  void _bankNameChanged() {
    // Focusing the text field triggers text change, so we have to do this
    if (_bankName == _bankNameController.text) {
      return;
    }
    _bankName = _bankNameController.text;
    context.read<CreditCardBloc>().add(CreditCardEvent.bankNameChanged(newValue: _bankNameController.text));
  }
}