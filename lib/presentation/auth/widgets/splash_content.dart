import 'package:flutter/material.dart';
import 'package:greezy/presentation/shared/svg_image.dart';

class SplashContent extends StatelessWidget {
  final String text;
  final String image;
  final String title;

  const SplashContent({
    Key? key,
    required this.image,
    required this.text,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SvgImage(
            image: image,
            label: "Splash image",
            height: 300,
            width: 250,
          ),
        ),
        const Spacer(flex: 2),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
