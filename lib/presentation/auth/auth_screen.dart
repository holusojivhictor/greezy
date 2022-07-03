import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/domain/app_constants.dart';
import 'package:greezy/presentation/shared/default_button.dart';

import 'widgets/splash_content.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 65,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemCount: Data.splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: Data.splashData[index].image,
                    title: Data.splashData[index].title,
                    text: Data.splashData[index].text,
                  ),
                ),
              ),
              Expanded(
                flex: 35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(Data.splashData.length, (index) => buildDot(index: index)),
                    ),
                    const SizedBox(height: 20),
                    DefaultButton(
                      isPrimary: true,
                      text: "Sign Up",
                      onPressed: () {
                        context.read<SessionBloc>().add(const SessionEvent.signUpRequested());
                      },
                    ),
                    DefaultButton(
                      isPrimary: false,
                      hasBorder: true,
                      text: "Sign In",
                      onPressed: () {
                        context.read<SessionBloc>().add(const SessionEvent.signInRequested());
                      },
                    ),
                    DefaultButton(
                      isPrimary: false,
                      hasBorder: true,
                      text: "Sign in with Google",
                      onPressed: () {
                        context.read<GoogleSignInBloc>().add(const GoogleSignInEvent.signIn());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: kPadding / 2),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? theme.colorScheme.primary : theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
