import 'package:flutter/material.dart';
import 'package:greezy/presentation/shared/bottom_sheets/common_bottom_sheet.dart';

class MenuItemBottomSheet extends StatelessWidget {
  const MenuItemBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet(
      title: 'Order',
      titleIcon: Icons.outdoor_grill,
      showOkButton: false,
      showCancelButton: false,
      child: Container(),
    );
  }
}
