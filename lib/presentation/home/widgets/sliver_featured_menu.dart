import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/assets.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/presentation/featured/featured_menu.dart';
import 'package:greezy/presentation/shared/choice/choice_bar_with_icon.dart';
import 'package:greezy/presentation/shared/nothing_found.dart';
import 'package:greezy/presentation/shared/sliver_loading.dart';
import 'package:greezy/theme.dart';

class SliverFeaturedMenu extends StatelessWidget {
  const SliverFeaturedMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const SliverLoading(),
          loaded: (state) {
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: Styles.homeContentPadding,
                    child: ChoiceBarWithIconWithAllValue(
                      values: MenuMealType.values.map((e) => e.index).toList(),
                      selectedValue: state.mealType?.index,
                      onAllOrValueSelected: (v) {
                        context.read<HomeBloc>().add(HomeEvent.menuMealTypeChanged(v != null ? MenuMealType.values[v] : null));
                        context.read<HomeBloc>().add(const HomeEvent.applyFilterChanges());
                      },
                      choiceText: (val, _) => Assets.translateMenuMealType(MenuMealType.values[val]),
                      iconData: (val, _) => Assets.translateMenuMealTypeIcon(MenuMealType.values[val]),
                    ),
                  ),
                  if (state.featuredMenu.isNotEmpty) FeaturedMenu(menu: state.featuredMenu) else const NothingFound(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
