import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/presentation/shared/extensions/app_theme_type_extensions.dart';
import 'package:greezy/theme.dart';

import 'main_tab_page.dart';
import 'shared/loading.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (ctx, state) => state.map<Widget>(
        loading: (_) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: GreezyTheme.light(),
            home: const Loading(),
          );
        },
        loaded: (s) {
          final autoThemeModeOn = s.autoThemeMode == AutoThemeModeType.on;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: s.appTitle,
            theme: autoThemeModeOn ? GreezyTheme.light() : s.theme.getThemeData(s.theme),
            darkTheme: autoThemeModeOn ? GreezyTheme.dark() : null,
            home: const MainTabPage(),
          );
        },
      ),
    );
  }
}
