import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/presentation/menu/menu_page.dart';
import 'package:greezy/presentation/menu/widgets/menu_item_card.dart';
import 'package:greezy/presentation/shared/app_fab.dart';
import 'package:greezy/presentation/shared/mixins/app_fab_mixin.dart';
import 'package:greezy/presentation/shared/nothing_found_column.dart';
import 'package:greezy/presentation/shared/utils/size_utils.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class MenuInventoryPage extends StatefulWidget {
  const MenuInventoryPage({Key? key}) : super(key: key);

  @override
  State<MenuInventoryPage> createState() => _MenuInventoryPageState();
}

class _MenuInventoryPageState extends State<MenuInventoryPage> with SingleTickerProviderStateMixin, AppFabMixin {
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
          onPressed: () => _openProductsPage(context),
          icon: const Icon(Icons.add),
          hideFabAnimController: hideFabAnimController,
          scrollController: scrollController,
          mini: false,
        ),
        body: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (ctx, state) => state.menu.isNotEmpty ? WaterfallFlow.builder(
            controller: scrollController,
            itemBuilder: (context, index) => MenuItemCard.favorite(menuItem: state.menu[index]),
            itemCount: state.menu.length,
            gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ) : const NothingFoundColumn(),
        ),
      ),
    );
  }

  Future<void> _openProductsPage(BuildContext context) async {
    final inventoryBloc = context.read<InventoryBloc>();
    final menuBloc = context.read<MenuBloc>();
    menuBloc.add(MenuEvent.init(excludeKeys: inventoryBloc.getItemsKeysToExclude()));
    final route = MaterialPageRoute<int>(builder: (_) => const MenuPage(isInSelectionMode: true));
    final key = await Navigator.push(context, route);

    menuBloc.add(const MenuEvent.init());
    if (key == null) {
      return;
    }

    inventoryBloc.add(InventoryEvent.addMeal(key: key));
  }
}
