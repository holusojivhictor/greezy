import 'package:flutter/material.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/presentation/menu/widgets/menu_bottom_sheet.dart' as menu;
import 'package:greezy/presentation/shared/bottom_sheets/custom_bottom_sheet.dart';
import 'package:greezy/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ModalBottomSheetUtils {
  static Widget getBottomSheetFromEndDrawerItemType(BuildContext context, EndDrawerItemType? type, {Map<String, dynamic>? args}) {
    switch (type) {
      case EndDrawerItemType.order:
        // TODO: Handle this case.
        break;
      case EndDrawerItemType.menu:
        return const menu.MenuBottomSheet();
      case EndDrawerItemType.creditCard:
        // TODO: Handle this case.
        break;
    }
    return Container();
  }

  static Future<void> showAppModalBottomSheet(BuildContext context, EndDrawerItemType type, {Map<String, dynamic>? args}) async {
    final size = MediaQuery.of(context).size;
    final device = getDeviceType(size);

    if (device == DeviceScreenType.mobile) {
      await showModalBottomSheet(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
        shape: Styles.modalBottomSheetShape,
        isDismissible: true,
        isScrollControlled: true,
        builder: (ctx) => getBottomSheetFromEndDrawerItemType(context, type, args: args),
      );
      return;
    }

    await showCustomModalBottomSheet(
      context: context,
      builder: (ctx) => getBottomSheetFromEndDrawerItemType(context, type, args: args),
    );
  }
}