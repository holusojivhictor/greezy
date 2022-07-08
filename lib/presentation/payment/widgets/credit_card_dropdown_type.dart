import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/assets.dart';
import 'package:greezy/presentation/shared/drop_down/dropdown_button_with_title.dart';
import 'package:greezy/presentation/shared/utils/enum_utils.dart';

class CreditCardDropdownType extends StatelessWidget {
  final CardType selectedValue;
  final bool isInEditMode;
  final bool isExpanded;

  const CreditCardDropdownType({
    Key? key,
    required this.selectedValue,
    required this.isInEditMode,
    this.isExpanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translatedValues = EnumUtils.getTranslatedAndSortedEnum<CardType>(CardType.values, (type, _) => Assets.translateCardType(type));

    return DropdownButtonWithTitle<CardType>(
      margin: EdgeInsets.zero,
      title: 'Card Type',
      isExpanded: isExpanded,
      currentValue: translatedValues.firstWhere((el) => el.enumValue == selectedValue).enumValue,
      items: translatedValues,
      onChanged: isInEditMode ? null : (v) => context.read<CreditCardBloc>().add(CreditCardEvent.cardTypeChanged(newValue: v)),
    );
  }
}
