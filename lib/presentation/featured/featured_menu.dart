import 'package:flutter/material.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/presentation/menu/widgets/featured_card.dart';
import 'package:greezy/theme.dart';

class FeaturedMenu extends StatelessWidget {
  final List<MenuCardModel> menu;

  const FeaturedMenu({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.homeContentPadding,
      child: SizedBox(
        height: Styles.featuredCardHeight,
        child: ListView.separated(
          separatorBuilder: (ctx, index) => const SizedBox(width: 15),
          itemCount: menu.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            final e = menu[index];
            return FeaturedCard.item(menuItem: e, width: Styles.featuredCardWidth);
          },
        ),
      ),
    );
  }
}
