import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String image;
  final String label;
  final double? width;
  final double? height;
  final BoxFit fit;

  const SvgImage({
    Key? key,
    required this.image,
    required this.label,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      width: width,
      height: height,
      fit: fit,
      semanticsLabel: label,
    );
  }
}