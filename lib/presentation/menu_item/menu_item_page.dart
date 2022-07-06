import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/injection.dart';

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
    return Container();
  }
}
