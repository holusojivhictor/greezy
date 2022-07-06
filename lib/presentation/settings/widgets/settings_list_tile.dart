import 'package:flutter/material.dart';
import 'package:greezy/theme.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Widget? trailing;
  final void Function()? onTap;

  const SettingsListTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(title, style: theme.textTheme.bodyMedium!.copyWith(color: theme.indicatorColor)),
      dense: true,
      minLeadingWidth: 20,
      contentPadding: Styles.edgeInsetHorizontal5,
      onTap: onTap != null ? () => onTap!() : null,
      leading: Icon(leadingIcon, size: 22),
      trailing: trailing,
    );
  }
}
