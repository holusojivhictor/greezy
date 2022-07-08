import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/app_constants.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/presentation/shared/container_tag.dart';
import 'package:greezy/presentation/shared/counter_button.dart';
import 'package:greezy/presentation/shared/default_button.dart';
import 'package:greezy/presentation/shared/details/detail_bottom_layout.dart';
import 'package:greezy/presentation/shared/expandable_text.dart';
import 'package:greezy/presentation/shared/loading.dart';
import 'package:greezy/presentation/shared/utils/modal_bottom_sheet_utils.dart';
import 'package:greezy/theme.dart';

import 'detail_title.dart';

class MenuItemDetailBottom extends StatelessWidget {
  const MenuItemDetailBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<MenuItemBloc, MenuItemState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) => DetailBottomLayout(
          color: theme.scaffoldBackgroundColor,
          children: [
            Padding(
              padding: Styles.edgeInsetAll10,
              child: Text(
                state.title,
                style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, color: theme.indicatorColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const SizedBox(width: 5),
                  Text(
                    '${state.rating}',
                    style: theme.textTheme.bodyMedium!.copyWith(color: theme.indicatorColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '(${state.ratingCount} Reviews)',
                    style: theme.textTheme.bodyMedium!.copyWith(color: theme.indicatorColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: Styles.edgeInsetAll10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '\$',
                      style: theme.textTheme.bodyMedium!.copyWith(color: theme.primaryColor, fontSize: 14),
                      children: <TextSpan> [
                        TextSpan(
                          text: "${state.price}",
                          style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 22, color: theme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CounterButton(
                        icon: Icons.remove,
                        color: Colors.transparent,
                        hasBorder: true,
                        iconColor: theme.primaryColor,
                        onPressed: state.orderQuantity == 1 ? null : () => context.read<MenuItemBloc>().add(const MenuItemEvent.decrementQuantity()),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${state.orderQuantity}',
                        style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      CounterButton(
                        icon: Icons.add,
                        color: theme.primaryColor,
                        iconColor: Colors.white,
                        onPressed: () => context.read<MenuItemBloc>().add(const MenuItemEvent.incrementQuantity()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: Styles.edgeInsetAll10,
              child: ExpandableText(
                constantDescription,
                trimLines: 3,
                trimMode: TrimMode.line,
                trimCollapsedText: '...Read More',
                trimExpandedText: ' Less',
                style: theme.textTheme.bodyLarge!.copyWith(color: theme.indicatorColor),
              ),
            ),
            DetailTitle(theme: theme, text: 'Health labels'),
            Padding(
              padding: Styles.edgeInsetAll10,
              child: Row(
                children: getTags(state.healthLabels),
              ),
            ),
            const SizedBox(height: 30),
            DefaultButton(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              isPrimary: true,
              text: 'Order',
              onPressed: () => ModalBottomSheetUtils.showAppModalBottomSheet(context, EndDrawerItemType.order),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getTags(List<String> healthLabels) {
    return healthLabels.map((e) => Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ContainerTag(tagText: e, isHealthLabel: true),
    )).toList();
  }
}