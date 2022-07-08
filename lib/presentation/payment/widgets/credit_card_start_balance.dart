import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';

class CreditCardStartBalance extends StatefulWidget {
  final double startBalance;
  const CreditCardStartBalance({Key? key, required this.startBalance}) : super(key: key);

  @override
  State<CreditCardStartBalance> createState() => _CreditCardStartBalanceState();
}

class _CreditCardStartBalanceState extends State<CreditCardStartBalance> {
  late TextEditingController _startBalanceController;
  late String _startBalance;

  @override
  void initState() {
    _startBalance = widget.startBalance.toString();
    _startBalanceController = TextEditingController(text: _startBalance);
    _startBalanceController.addListener(_startBalanceChanged);
    super.initState();
  }

  @override
  void dispose() {
    _startBalanceController.removeListener(_startBalanceChanged);
    _startBalanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreditCardBloc, CreditCardState>(
      listener: (ctx, state) {
        if ('${state.startBalance}' != _startBalance) {
          setState(() {
            _startBalance = state.startBalance.toString();
            _startBalanceController.text = _startBalance;
          });
        }
      },
      builder: (ctx, state) => TextField(
        controller: _startBalanceController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Card Balance',
          alignLabelWithHint: true,
          labelText: 'Card Balance',
        ),
      ),
    );
  }

  void _startBalanceChanged() {
    // Focusing the text field triggers text change, so we have to do this
    if (_startBalance == _startBalanceController.text) {
      return;
    }
    _startBalance = _startBalanceController.text;
    context.read<CreditCardBloc>().add(CreditCardEvent.startBalanceChanged(newValue: double.parse(_startBalanceController.text)));
  }
}