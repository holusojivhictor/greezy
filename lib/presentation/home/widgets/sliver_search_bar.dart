import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/presentation/inventory/inventory_page.dart';
import 'package:greezy/presentation/shared/search_field.dart';

class SliverSearchBar extends StatelessWidget {
  const SliverSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) => state.map(
                loading: (_) => const SizedBox.shrink(),
                loaded: (state) {
                  return SearchField(
                    value: state.search,
                    searchChanged: (v) => context.read<HomeBloc>().add(HomeEvent.searchChanged(search: v)),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () => _goToInventoryPage(context),
              child: Container(
                padding: const EdgeInsets.all(5),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.favorite_rounded, size: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToInventoryPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => const InventoryPage());
    await Navigator.push(context, route);
    await route.completed;
  }
}
