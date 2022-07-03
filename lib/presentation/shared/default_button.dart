import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool hasBorder;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double minHeight;
  final Color? backgroundColor;

  const DefaultButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
    this.hasBorder = false,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
    this.borderRadius = 10,
    this.minHeight = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width * 0.9;

    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: backgroundColor != null ? MaterialStateProperty.all(backgroundColor) : MaterialStateProperty.all(isPrimary ? theme.primaryColor : theme.scaffoldBackgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
              side: hasBorder
                  ? BorderSide(color: theme.indicatorColor)
                  : BorderSide.none,
            ),
          ),
          shadowColor: MaterialStateProperty.all(theme.shadowColor),
          minimumSize: MaterialStateProperty.all(Size(width, minHeight)),
        ),
        onPressed: onPressed,
        child: Text(text, style: theme.textTheme.bodyLarge!.copyWith(color: isPrimary ? Colors.white : null)),
      ),
    );
  }
}