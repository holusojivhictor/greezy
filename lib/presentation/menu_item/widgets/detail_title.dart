import 'package:flutter/material.dart';

class DetailTitle extends StatelessWidget {
  const DetailTitle({
    Key? key,
    required this.theme,
    required this.text,
  }) : super(key: key);

  final ThemeData theme;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        text,
        style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: theme.indicatorColor),
      ),
    );
  }
}