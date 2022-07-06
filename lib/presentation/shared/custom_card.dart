import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final BorderRadius? borderRadius;
  final ShapeBorder? shape;
  final Clip clipBehavior;
  final EdgeInsetsGeometry margin;
  final bool semanticContainer;
  final LinearGradient? gradient;
  final Widget? child;
  final Color? color;
  final double? elevation;
  final Color? shadowColor;
  final bool isBuggy;

  const CustomCard({
    Key? key,
    this.color,
    this.borderRadius,
    this.shape,
    this.margin = const EdgeInsets.all(4),
    this.clipBehavior = Clip.none,
    this.gradient,
    this.child,
    this.elevation,
    this.shadowColor,
    this.semanticContainer = true,
    this.isBuggy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: semanticContainer,
      explicitChildNodes: !semanticContainer,
      child: Material(
        type: MaterialType.card,
        color: Colors.transparent,
        shadowColor: shadowColor ?? Colors.transparent,
        borderOnForeground: false,
        elevation: elevation ?? 0,
        shape: shape ?? const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        clipBehavior: clipBehavior,
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(4)),
            color: color,
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}