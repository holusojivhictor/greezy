import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greezy/domain/assets.dart';
import 'package:greezy/theme.dart';

import 'size_utils.dart';

class DetailTopLayout extends StatelessWidget {
  final String image;
  final Color? color;
  final Widget? appBar;
  final BorderRadius? borderRadius;

  const DetailTopLayout({
    Key? key,
    required this.image,
    this.color,
    this.appBar,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getTopHeightForPortrait(context),
      decoration: BoxDecoration(
        color: color,
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Image(
                image: CachedNetworkImageProvider(Assets.getImageCloudPath(image)),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Positioned(
            top: 25.0,
            left: 0.0,
            right: 0.0,
            child: appBar ?? const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
