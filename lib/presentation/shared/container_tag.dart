import 'package:flutter/material.dart';

class ContainerTag extends StatelessWidget {
  final Color color;
  final bool hasBorder;
  final String tagText;
  final bool isHealthLabel;

  const ContainerTag({
    Key? key,
    required this.tagText,
    this.color = Colors.white,
    this.hasBorder = true,
    this.isHealthLabel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isHealthLabel ? 5 : 2),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: hasBorder ? Colors.grey.withOpacity(0.5) : Colors.white),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tagText,
        style: TextStyle(fontSize: isHealthLabel ? 14 : 10),
      ),
    );
  }
}
