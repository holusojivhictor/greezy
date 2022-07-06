import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greezy/domain/assets.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/presentation/shared/container_tag.dart';
import 'package:greezy/presentation/shared/custom_card.dart';
import 'package:greezy/presentation/shared/price_overlay.dart';
import 'package:greezy/presentation/shared/rating_overlay.dart';
import 'package:greezy/theme.dart';

class FeaturedCard extends StatelessWidget {
  final int id;
  final String title;
  final double price;
  final String image;
  final double rating;
  final int ratingCount;
  final List<MenuDishType> dishType;
  final double width;

  final double imgWidth;
  final double imgHeight;
  final bool withElevation;

  const FeaturedCard({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    required this.ratingCount,
    required this.dishType,
    this.width = 200,
    this.imgWidth = 180,
    this.imgHeight = 180,
    this.withElevation = true,
  }) : super(key: key);

  FeaturedCard.item({
    Key? key,
    required MenuCardModel menuItem,
    this.width = 200,
    this.imgWidth = 180,
    this.imgHeight = 150,
    this.withElevation = true,
  })  : id = menuItem.id,
        title = menuItem.title,
        price = menuItem.price,
        image = menuItem.image,
        rating = menuItem.rating,
        ratingCount = menuItem.ratingCount,
        dishType = menuItem.dishType,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      child: CustomCard(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        shape: Styles.mainCardShape,
        elevation: withElevation ? Styles.cardTenElevation : 0,
        color: kWhite,
        child: Padding(
          padding: Styles.edgeInsetAll5,
          child: SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  fit: StackFit.passthrough,
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        width: imgWidth,
                        height: imgHeight,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        image: CachedNetworkImageProvider(Assets.getImageCloudPath(image)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PriceOverlay(price: price),
                      ],
                    ),
                    Positioned(
                      left: 5,
                      bottom: -10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AltRatingOverlay(rating: rating, ratingCount: ratingCount),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Tooltip(
                      message: title,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: theme.textTheme.bodyLarge!.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: getTags(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getTags() {
    return dishType.map((e) => ContainerTag(tagText: Assets.translateMenuDishType(e))).toList();
  }
}
