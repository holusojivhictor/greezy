import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/presentation/shared/details/detail_top_layout.dart';
import 'package:greezy/presentation/shared/loading.dart';
import 'package:greezy/presentation/shared/utils/toast_utils.dart';
import 'package:greezy/theme.dart';

class MenuItemDetailTop extends StatelessWidget {
  const MenuItemDetailTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<MenuItemBloc, MenuItemState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) => DetailTopLayout(
          image: state.image,
          borderRadius: BorderRadius.circular(10),
          appBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.grey, size: 20),
                  ),
                ),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: theme.primaryColor,
                  child: IconButton(
                    icon: Icon(state.isInInventory ? Icons.favorite : Icons.favorite_border),
                    color: kWhite,
                    splashRadius: Styles.mediumButtonSplashRadius,
                    onPressed: () => _favoriteMeal(state.id, state.isInInventory, context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _favoriteMeal(int key, bool isInInventory, BuildContext context) {
    final fToast = ToastUtils.of(context);
    final event = !isInInventory ? MenuItemEvent.addToInventory(key: key) : MenuItemEvent.deleteFromInventory(key: key);
    context.read<MenuItemBloc>().add(event);
    !isInInventory ? ToastUtils.showSucceedToast(fToast, 'Added to inventory') : ToastUtils.showInfoToast(fToast, 'Removed from inventory');
  }
}
