import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/models/models.dart' as models;
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';

class CreditCardListTile extends StatefulWidget {
  final int itemKey;
  final String cardNumber;
  final String cardSecurityCode;
  final String cardExpiryDate;
  final String cardHolderName;
  final String bankName;

  CreditCardListTile({
    Key? key,
    required models.CreditCardItem item,
  })  : itemKey = item.key,
        cardNumber = item.cardNumber,
        cardSecurityCode = item.cardSecurityCode,
        cardExpiryDate = item.cardExpiryDate,
        cardHolderName = item.cardHolderName,
        bankName = item.bankName,
        super(key: key);

  @override
  State<CreditCardListTile> createState() => _CreditCardListTileState();
}

class _CreditCardListTileState extends State<CreditCardListTile> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (context) => context.read<CreditCardsBloc>().add(CreditCardsEvent.delete(id: widget.itemKey)),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            tapped = !tapped;
          });
        },
        child: CreditCard(
          cardNumber: widget.cardNumber,
          cardExpiry: widget.cardExpiryDate,
          cardHolderName: widget.cardHolderName,
          cvv: widget.cardSecurityCode,
          bankName: widget.bankName,
          cardType: CardType.masterCard,
          showBackSide: tapped,
          frontBackground: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                  Colors.grey,
                ]
              ),
            ),
          ),
          backBackground: CardBackgrounds.white,
          horizontalMargin: 10,
          showShadow: false,
          textExpDate: 'Exp. Date',
          textName: 'Name',
          textExpiry: 'MM/YY',
        ),
      ),
    );
  }
}
