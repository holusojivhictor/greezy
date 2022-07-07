import 'package:flutter/material.dart';
import 'package:greezy/presentation/shared/app_fab.dart';
import 'package:greezy/presentation/shared/mixins/app_fab_mixin.dart';
import 'package:greezy/presentation/shared/nothing_found_column.dart';

class CreditCardsPage extends StatefulWidget {
  const CreditCardsPage({Key? key}) : super(key: key);

  @override
  State<CreditCardsPage> createState() => _CreditCardsPageState();
}

class _CreditCardsPageState extends State<CreditCardsPage> with SingleTickerProviderStateMixin, AppFabMixin {
  @override
  bool get isInitiallyVisible => true;

  @override
  bool get hideOnTop => false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Scaffold(
        floatingActionButton: AppFab(
          onPressed: () {},
          icon: const Icon(Icons.add),
          hideFabAnimController: hideFabAnimController,
          scrollController: scrollController,
          mini: false,
        ),
        body: const NothingFoundColumn(msg: "Click on the add button to create a new card"),
      ),
    );
  }
}