import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/assets.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/presentation/shared/bottom_sheets/common_bottom_sheet.dart';
import 'package:greezy/presentation/shared/bottom_sheets/common_button_bar.dart';
import 'package:greezy/presentation/shared/item_popup_menu_filter.dart';
import 'package:greezy/presentation/shared/loading.dart';
import 'package:greezy/presentation/shared/sort_direction_popup_menu_filter.dart';
import 'package:greezy/theme.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet(
      title: 'Filters',
      titleIcon: Icons.sort,
      showCancelButton: false,
      showOkButton: false,
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) => state.map(
          loading: (_) => const Loading(useScaffold: false),
          loaded: (state) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Secondary'),
              _SecondaryFilters(
                tempMenuMealType: state.tempMealType,
                tempMenuFilterType: state.tempMenuFilterType,
                tempSortDirectionType: state.tempSortDirectionType,
              ),
              const _ButtonBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryFilters extends StatelessWidget {
  final MenuMealType? tempMenuMealType;
  final MenuFilterType tempMenuFilterType;
  final SortDirectionType tempSortDirectionType;

  const _SecondaryFilters({
    Key? key,
    required this.tempMenuMealType,
    required this.tempMenuFilterType,
    required this.tempSortDirectionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonButtonBar(
      spacing: 5,
      alignment: WrapAlignment.spaceBetween,
      children: [
        ItemPopupMenuFilterWithAllValue(
          toolTipText: 'Menu meal type',
          values: MenuMealType.values.map((e) => e.index).toList(),
          selectedValue: tempMenuMealType?.index,
          onAllOrValueSelected: (v) => context.read<MenuBloc>().add(MenuEvent.menuMealTypeChanged(v != null ? MenuMealType.values[v] : null)),
          icon: Icon(Icons.tune, size: Styles.getIconSizeForItemPopupMenuFilter(true)),
          itemText: (val, _) => Assets.translateMenuMealType(MenuMealType.values[val]),
        ),
        ItemPopupMenuFilter<MenuFilterType>(
          toolTipText: 'Sort by',
          selectedValue: tempMenuFilterType,
          values: MenuFilterType.values,
          onSelected: (v) => context.read<MenuBloc>().add(MenuEvent.menuFilterTypeChanged(v)),
          icon: Icon(Icons.filter_list, size: Styles.getIconSizeForItemPopupMenuFilter(true)),
          itemText: (val, _) => Assets.translateMenuFilterType(val),
        ),
        SortDirectionPopupMenuFilter(
          selectedSortDirection: tempSortDirectionType,
          onSelected: (v) => context.read<MenuBloc>().add(MenuEvent.sortDirectionChanged(v)),
          icon: Icon(Icons.sort, size: Styles.getIconSizeForItemPopupMenuFilter(true)),
        ),
      ],
    );
  }
}


class _ButtonBar extends StatelessWidget {
  const _ButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CommonButtonBar(
      children: <Widget>[
        OutlinedButton(
          onPressed: () {
            context.read<MenuBloc>().add(const MenuEvent.cancelChanges());
            Navigator.pop(context);
          },
          child: Text('Cancel', style: TextStyle(color: theme.primaryColor)),
        ),
        OutlinedButton(
          onPressed: () {
            context.read<MenuBloc>().add(const MenuEvent.resetFilters());
            Navigator.pop(context);
          },
          child: Text('Reset', style: TextStyle(color: theme.primaryColor)),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(theme.primaryColor.withOpacity(0.7)),
          ),
          onPressed: () {
            context.read<MenuBloc>().add(const MenuEvent.applyFilterChanges());
            Navigator.pop(context);
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}