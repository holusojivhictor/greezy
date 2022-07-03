import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTextSplash extends StatelessWidget {
  const AnimatedTextSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Presented by...',
                style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  'Victor Olusoji',
                  style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(3),
                child: TextLiquidFill(
                  text: 'GREEZY',
                  waveColor: Colors.black,
                  loadDuration: const Duration(milliseconds: 2500),
                  boxBackgroundColor: theme.scaffoldBackgroundColor,
                  textStyle: theme.textTheme.displayMedium!.copyWith(fontSize: 50, fontWeight: FontWeight.bold),
                  boxHeight: 85,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
