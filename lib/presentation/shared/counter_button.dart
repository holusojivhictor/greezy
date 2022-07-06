import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color color;
  final bool hasBorder;
  final void Function()? onPressed;

  const CounterButton({
    Key? key,
    required this.icon,
    this.iconColor = Colors.black54,
    required this.color,
    this.hasBorder = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 35,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          border: hasBorder ?  Border.all(color: Theme.of(context).primaryColor) : null,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}