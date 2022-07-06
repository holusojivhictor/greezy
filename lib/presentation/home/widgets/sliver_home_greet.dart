import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/presentation/shared/loading.dart';

class SliverHomeGreet extends StatelessWidget {
  const SliverHomeGreet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (ctx, state) => state.map(
            loading: (_) => const Loading(useScaffold: false),
            loaded: (state) {
              final displayName = state.displayName;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Hello, \n',
                      style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                      children: <TextSpan> [
                        TextSpan(
                          text: '$displayName 👋',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: "It's ",
                      style: theme.textTheme.bodyLarge!.copyWith(fontSize: 15),
                      children: <TextSpan> [
                        TextSpan(
                          text: state.timeParsed,
                          style: theme.textTheme.bodyLarge!.copyWith(fontSize: 15, color: theme.primaryColor),
                        ),
                        TextSpan(
                          text: " time!",
                          style: theme.textTheme.bodyLarge!.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
