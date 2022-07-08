import 'package:flutter/material.dart';
import 'package:greezy/domain/assets.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/presentation/menu_item/menu_item_page.dart';
import 'package:greezy/presentation/shared/container_tag.dart';
import 'package:greezy/presentation/shared/custom_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:greezy/presentation/shared/rating_overlay.dart';
import 'package:greezy/presentation/shared/transparent_image.dart';
import 'package:greezy/theme.dart';

class MenuItemCard extends StatelessWidget {
  final int id;
  final String title;
  final double price;
  final String image;
  final double rating;
  final List<MenuDishType> dishType;
  final double width;

  final double imgWidth;
  final double imgHeight;
  final bool isInSelectionMode;
  final bool withElevation;
  final bool isPopular;
  final bool isFavorite;

  const MenuItemCard({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    required this.dishType,
    this.width = 160,
    this.imgWidth = 140,
    this.imgHeight = 140,
    this.isInSelectionMode = false,
    this.withElevation = true,
    this.isPopular = false,
    this.isFavorite = false,
  }) : super(key: key);

  MenuItemCard.item({
    Key? key,
    required MenuCardModel menuItem,
    this.width = 160,
    this.imgWidth = 140,
    this.imgHeight = 140,
    this.isInSelectionMode = false,
    this.withElevation = true,
    this.isPopular = false,
    this.isFavorite = false,
  })  : id = menuItem.id,
        title = menuItem.title,
        price = menuItem.price,
        image = menuItem.image,
        rating = menuItem.rating,
        dishType = menuItem.dishType,
        super(key: key);

  MenuItemCard.popular({
    Key? key,
    required MenuCardModel menuItem,
    this.width = 160,
    this.imgWidth = 160,
    this.imgHeight = 160,
    this.isInSelectionMode = false,
    this.withElevation = true,
    this.isPopular = true,
    this.isFavorite = false,
  })  : id = menuItem.id,
        title = menuItem.title,
        price = menuItem.price,
        image = menuItem.image,
        rating = menuItem.rating,
        dishType = menuItem.dishType,
        super(key: key);

  MenuItemCard.favorite({
    Key? key,
    required MenuCardModel menuItem,
    this.width = 160,
    this.imgWidth = 160,
    this.imgHeight = 160,
    this.isInSelectionMode = false,
    this.withElevation = true,
    this.isPopular = false,
    this.isFavorite = true,
  })  : id = menuItem.id,
        title = menuItem.title,
        price = menuItem.price,
        image = menuItem.image,
        rating = menuItem.rating,
        dishType = menuItem.dishType,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _goToMealPage(context),
      child: CustomCard(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        shape: Styles.mainCardShape,
        borderRadius: Styles.mainCardBorderRadius,
        elevation: withElevation ? 2 : 0,
        shadowColor: Colors.white12,
        color: kWhite,
        child: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                fit: StackFit.passthrough,
                children: [
                  FadeInImage(
                    width: width,
                    fadeInDuration: const Duration(milliseconds: 50),
                    placeholder: MemoryImage(kTransparentImage),
                    image: CachedNetworkImageProvider(Assets.getImageCloudPath(image)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingOverlay(rating: rating),
                    ],
                  ),
                  Positioned(
                    bottom: 5,
                    left: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: getTags(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: isPopular || isFavorite ? 30 : null,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Tooltip(
                    message: title,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: theme.textTheme.bodyLarge!.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '\$',
                        style: theme.textTheme.bodyMedium!.copyWith(color: theme.primaryColor, fontSize: 12),
                        children: <TextSpan> [
                          TextSpan(
                            text: "$price",
                            style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    if (isPopular)
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: Styles.edgeInsetAll5,
                        child: const RadialGradientMask(
                          child: Icon(Icons.local_fire_department_rounded, color: Colors.white),
                        ),
                      ),
                    if (isFavorite)
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        padding: Styles.edgeInsetAll5,
                        child: const Icon(Icons.favorite_rounded, color: Color(0xFFDD5E65)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToMealPage(BuildContext context) async {
    if (isInSelectionMode) {
      Navigator.pop(context, id);
      return;
    }

    final route = MaterialPageRoute(builder: (c) => MenuItemPage(itemKey: id));
    await Navigator.push(context, route);
    await route.completed;
  }

  List<Widget> getTags() {
    return dishType.map((e) => Padding(
      padding: const EdgeInsets.only(right: 5),
      child: ContainerTag(tagText: Assets.translateMenuDishType(e), hasBorder: false),
    )).toList();
  }
}

class RadialGradientMask extends StatelessWidget {
  final Widget child;
  const RadialGradientMask({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Color(0xFFDD5E65), Color(0xFFDD5E65)],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}