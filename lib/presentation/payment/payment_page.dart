import 'package:flutter/material.dart';
import 'package:greezy/domain/app_constants.dart';
import 'package:greezy/presentation/payment/widgets/cards_page.dart';
import 'package:greezy/presentation/shared/dialogs/info_dialog.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: SafeArea(
        child: CreditCardsPage(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text('Payment Service', style: theme.textTheme.bodyLarge!.copyWith(color: theme.indicatorColor, fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          tooltip: "Information",
          icon: const Icon(Icons.info, color: Colors.grey),
          onPressed: () => _showInfoDialog(context),
        ),
      ],
    );
  }

  Future<void> _showInfoDialog(BuildContext context) async {
    final explanations = [
      infoA,
      infoB,
      infoC,
    ];
    await showDialog(
      context: context,
      builder: (context) => InfoDialog(explanations: explanations),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
