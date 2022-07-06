import 'package:flutter/material.dart';

double getTopHeightForPortrait(BuildContext context) {
  const factor = 0.3;
  final value = MediaQuery.of(context).size.height * factor;
  if (value > 400) {
    return 400;
  }
  return value;
}

double getTopMarginForPortrait(BuildContext context) {
  final maxTopHeight = (getTopHeightForPortrait(context)) - 10;
  return maxTopHeight;
}