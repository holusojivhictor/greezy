import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/presentation/payment/widgets/add_card_bottom_sheet.dart';
import 'package:greezy/presentation/payment/widgets/items/credit_card_list_tile.dart';
import 'package:greezy/presentation/shared/app_fab.dart';
import 'package:greezy/presentation/shared/mixins/app_fab_mixin.dart';
import 'package:greezy/presentation/shared/nothing_found_column.dart';
import 'package:greezy/presentation/shared/utils/modal_bottom_sheet_utils.dart';

class CreditCardsPage extends StatefulWidget {
  const CreditCardsPage({Key? key}) : super(key: key);

  @override
  State<CreditCardsPage> createState() => _CreditCardsPageState();
}

class _CreditCardsPageState extends State<CreditCardsPage> with SingleTickerProviderStateMixin, AppFabMixin {
  @override
  bool get isInitiallyVisible => true;

  @override
  bool get hideOnTop => false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AppFab(
        onPressed: () => _showAppModal(context),
        icon: const Icon(Icons.add),
        hideFabAnimController: hideFabAnimController,
        scrollController: scrollController,
        mini: false,
      ),
      body: BlocBuilder<CreditCardsBloc, CreditCardsState>(
        builder: (ctx, state) => state.map(
          initial: (state) {
            if (state.creditCards.isEmpty) {
              return const NothingFoundColumn(msg: "Click on the add button to create a new card");
            }

            return ListView.separated(
              separatorBuilder: (ctx, index) => const SizedBox(height: 15),
              itemCount: state.creditCards.length,
              itemBuilder: (ctx, index) {
                final e = state.creditCards[index];
                return CreditCardListTile(item: e);
              },
            );
          }
        ),
      ),
    );
  }

  Future<void> _showAppModal(BuildContext context) async {
    await ModalBottomSheetUtils.showAppModalBottomSheet(
      context,
      EndDrawerItemType.creditCard,
      args: AddCardBottomSheet.buildCreditCardArgsForAdd(
        '0000 0000 0000 0000',
        '000',
        '00/11',
        'John Doe',
        'Exodus Bank',
        CardType.masterCard,
        100,
      ),
    );
  }
}