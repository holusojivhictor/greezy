import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/injection.dart';
import 'package:greezy/theme.dart';

import 'widgets/clear_all_dialog.dart';
import 'widgets/menu_inventory_page.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injection.inventoryBloc..add(const InventoryEvent.init()),
      child: const Scaffold(
        appBar: _AppBar(),
        body: SafeArea(
          child: MenuInventoryPage(),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget{
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My Inventory'),
      actions: [
        IconButton(
          splashRadius: Styles.mediumButtonSplashRadius,
          icon: const Icon(Icons.clear_all),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<InventoryBloc>(),
              child: const ClearAllDialog(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
