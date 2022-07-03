import 'package:flutter/material.dart';

typedef OnTap = void Function();

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final OnTap? onTap;

  const AuthAppBar({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Sign Up",
        style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey),
      ),
      leading: InkWell(
        onTap: onTap,
        child: RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.arrow_right_alt_sharp,
            color: theme.indicatorColor,
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
