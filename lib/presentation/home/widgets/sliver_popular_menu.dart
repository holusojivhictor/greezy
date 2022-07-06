import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/presentation/popular/popular_menu.dart';
import 'package:greezy/presentation/shared/nothing_found.dart';
import 'package:greezy/presentation/shared/sliver_loading.dart';

class SliverPopularMenu extends StatelessWidget {
  const SliverPopularMenu({Key? key}) : super(key: key);

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
                  if (state.popularMenu.isNotEmpty) PopularMenu(menu: state.popularMenu) else const NothingFound(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
