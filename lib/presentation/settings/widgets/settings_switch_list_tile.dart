import 'package:flutter/material.dart';
import 'package:greezy/theme.dart';

class SettingsSwitchListTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final void Function()? onTap;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SettingsSwitchListTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
    this.onTap,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: theme.indicatorColor)),
      dense: true,
      minLeadingWidth: 20,
      contentPadding: Styles.edgeInsetHorizontal5,
      onTap: onTap != null ? () => onTap!() : null,
      leading: Icon(leadingIcon, size: 22),
      trailing: Switch(
        activeColor: Theme.of(context).primaryColor,
        value: value,
        onChanged: onChanged != null ? (value) => onChanged!(value) : null,
      ),
    );
  }
}
