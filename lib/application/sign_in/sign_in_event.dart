part of 'sign_in_bloc.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.signIn({
    required String emailAddress,
    required String password,
  }) = _SignIn;
}