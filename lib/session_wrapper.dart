import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/presentation/animated_text_splash/animated_text_splash.dart';
import 'package:greezy/presentation/auth/auth_screen.dart';
import 'package:greezy/theme.dart';

class SessionWrapper extends StatelessWidget {
  const SessionWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp(Widget? home) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: GreezyTheme.light(),
        darkTheme: GreezyTheme.light(),
        home: home,
      );
    }
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) => state.map(
        unInitialized: (_) => materialApp(const AnimatedTextSplash()),
        unAuthenticated: (_) => materialApp(const AuthScreen()),
        signUpState: (_) => Container(),
        signInState: (_) => Container(),
        authenticated: (_) => Container(),
      ),
    );
  }
}
