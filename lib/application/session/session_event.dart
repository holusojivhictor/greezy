part of 'session_bloc.dart';

@freezed
class SessionEvent with _$SessionEvent {
  const factory SessionEvent.appStarted({required bool init}) = _AppStarted;

  const factory SessionEvent.logOutRequested() = _LogOut;

  const factory SessionEvent.signUpRequested() = _SignUp;

  const factory SessionEvent.signInRequested() = _SignIn;

  const factory SessionEvent.initStartup() = _InitStartup;
}