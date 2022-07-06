import 'package:flutter/material.dart';

class PriceOverlay extends StatelessWidget {
  final double price;
  const PriceOverlay({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: '\$',
              style: theme.textTheme.bodySmall!.copyWith(color: theme.primaryColor, fontSize: 11),
              children: <TextSpan> [
                TextSpan(
                  text: "$price",
                  style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}