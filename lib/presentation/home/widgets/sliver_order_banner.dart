import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/assets.dart';
import 'package:greezy/presentation/shared/gradient_card.dart';
import 'package:greezy/theme.dart';

class SliverOrderBanner extends StatelessWidget {
  const SliverOrderBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.zero,
          height: 160,
          width: double.infinity,
          child: GradientCard(
            elevation: 0,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            gradient: const LinearGradient(
              stops: [0.1, 1],
              colors: [
                Color(0xFFDD5E65),
                Color(0xFFE79086),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Text.rich(
                    TextSpan(
                      text: "Get special discount\n",
                      style: TextStyle(color: kWhite),
                      children: const [
                        TextSpan(
                          text: "up to 95%",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 120,
                  child: Column(
                    children: const [
                      BackgroundText(),
                      BackgroundText(),
                      BackgroundText(),
                      BackgroundText(),
                    ],
                  ),
                ),
                Positioned(
                  right: -50,
                  bottom: -50,
                  child: Image.asset(
                    Assets.getImagePath("sandwich.png"),
                    height: 220,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 15,
                  child: InkWell(
                    onTap: () => _goToTab(context, 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: const Text("Order Now"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToTab(BuildContext context, int newIndex) => context.read<MainTabBloc>().add(MainTabEvent.goToTab(index: newIndex));
}

class BackgroundText extends StatelessWidget {
  const BackgroundText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'PROMO',
      style: TextStyle(
        fontSize: 40,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.white.withOpacity(0.08),
      ),
    );
  }
}

