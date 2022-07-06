import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';

import 'mobile_scaffold.dart';
import 'shared/utils/toast_utils.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({Key? key}) : super(key: key);

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> with SingleTickerProviderStateMixin {
  bool _didChangeDependencies = false;
  late TabController _tabController;
  final _defaultIndex = 0;
  DateTime? backButtonPressTime;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: _defaultIndex,
      length: 4,
      vsync: this,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didChangeDependencies) return;
    _didChangeDependencies = true;
    context.read<HomeBloc>().add(const HomeEvent.init());
    context.read<MenuBloc>().add(const MenuEvent.init());
    context.read<SettingsBloc>().add(const SettingsEvent.init());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => handleWillPop(),
      child: MobileScaffold(defaultIndex: _defaultIndex, tabController: _tabController),
    );
  }

  void _goToTab(int newIndex) => context.read<MainTabBloc>().add(MainTabEvent.goToTab(index: newIndex));

  Future<bool> handleWillPop() async {
    if (_tabController.index != _defaultIndex) {
      _goToTab(_defaultIndex);
      return false;
    }

    final settings = context.read<SettingsBloc>();
    if (!settings.doubleBackToClose()) {
      return true;
    }

    final now = DateTime.now();
    final mustWait = backButtonPressTime == null || now.difference(backButtonPressTime!) > ToastUtils.toastDuration;

    if (mustWait) {
      backButtonPressTime = now;
      final fToast = ToastUtils.of(context);
      ToastUtils.showInfoToast(fToast, 'Press once again to exit');
      return false;
    }

    return true;
  }
}
