import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/services/services.dart';
import 'package:greezy/firebase_options.dart';
import 'package:greezy/session_wrapper.dart';

import 'injection.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Injection.init();
  runApp(const Greezy());
}

class Greezy extends StatelessWidget {
  const Greezy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return SessionBloc(authService)..add(const SessionEvent.appStarted(init: true));
          },
        ),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return SignInBloc(authService, ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return SignUpBloc(authService, ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return GoogleSignInBloc(authService, ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(create: (ctx) => MainTabBloc()),
        BlocProvider(
          create: (ctx) {
            final greezyService = getIt<GreezyService>();
            return HomeBloc(greezyService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final greezyService = getIt<GreezyService>();
            return MenuBloc(greezyService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final loggingService = getIt<LoggingService>();
            final greezyService = getIt<GreezyService>();
            final settingsService = getIt<SettingsService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return MainBloc(
              loggingService,
              greezyService,
              settingsService,
              deviceInfoService,
            )..add(const MainEvent.init());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final settingsService = getIt<SettingsService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return SettingsBloc(settingsService, deviceInfoService, ctx.read<MainBloc>());
          },
        ),
      ],
      child: BlocBuilder<SessionBloc, SessionState>(
        builder: (ctx, state) => const SessionWrapper(),
      ),
    );
  }
}
