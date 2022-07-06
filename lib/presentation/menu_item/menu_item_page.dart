import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/injection.dart';
import 'package:greezy/presentation/menu_item/widgets/menu_item_detail_bottom.dart';
import 'package:greezy/presentation/menu_item/widgets/menu_item_detail_top.dart';
import 'package:greezy/presentation/shared/loading.dart';
import 'package:greezy/presentation/shared/scaffold_with_fab.dart';

class MenuItemPage extends StatelessWidget {
  final int itemKey;

  const MenuItemPage({Key? key, required this.itemKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MenuItemBloc>(
      create: (ctx) => Injection.menuItemBloc..add(MenuItemEvent.loadFromId(key: itemKey)),
      child: const _PortraitLayout(),
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithFab(
      child: BlocBuilder<MenuItemBloc, MenuItemState>(
        builder: (context, state) => state.map(
          loading: (_) => const Loading(useScaffold: false),
          loaded: (state) => Stack(
            fit: StackFit.passthrough,
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: const [
              MenuItemDetailTop(),
              MenuItemDetailBottom(),
            ],
          ),
        ),
      ),
    );
  }
}
