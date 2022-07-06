import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/presentation/shared/loading.dart';
import 'package:greezy/presentation/shared/search_field.dart';
import 'package:greezy/presentation/shared/sliver_nothing_found.dart';
import 'package:greezy/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:greezy/presentation/shared/utils/size_utils.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'widgets/menu_item_card.dart';

class MenuPage extends StatefulWidget {
  final bool isInSelectionMode;

  static Future<int?> forSelection(BuildContext context, {List<int> excludeKeys = const []}) async {
    final bloc = context.read<MenuBloc>();
    bloc.add(MenuEvent.init(excludeKeys: excludeKeys));

    final route = MaterialPageRoute<int>(builder: (ctx) => const MenuPage(isInSelectionMode: true));
    final key = await Navigator.of(context).push(route);
    await route.completed;

    bloc.add(const MenuEvent.init());

    return key;
  }

  const MenuPage({Key? key, this.isInSelectionMode = false}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with AutomaticKeepAliveClientMixin<MenuPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          appbar: widget.isInSelectionMode ? AppBar(title: const Text('Select a meal')) : null,
          slivers: [
            SliverToBoxAdapter(
              child: SearchField(
                value: state.search,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                searchChanged: (v) => context.read<MenuBloc>().add(MenuEvent.searchChanged(search: v)),
              ),
            ),
            if (state.menu.isNotEmpty) _buildGrid(context, state.menu) else const SliverNothingFound(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<MenuCardModel> menu) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      sliver: SliverWaterfallFlow(
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, isOnMainPage: !widget.isInSelectionMode),
          crossAxisSpacing: isPortrait ? 15 : 10,
          mainAxisSpacing: 15,
        ),
        delegate: SliverChildBuilderDelegate((context, index) => MenuItemCard.item(menuItem: menu[index], isInSelectionMode: widget.isInSelectionMode),
          childCount: menu.length,
        ),
      ),
    );
  }
}
