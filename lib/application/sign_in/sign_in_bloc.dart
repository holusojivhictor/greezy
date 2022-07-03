import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greezy/application/bloc.dart';
import 'package:greezy/application/result_state/result_state.dart';
import 'package:greezy/domain/models/models.dart';
import 'package:greezy/domain/models/network/network_exceptions.dart';
import 'package:greezy/domain/services/services.dart';

part 'sign_in_bloc.freezed.dart';
part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, ResultState<String>> {
  final AuthService _authService;
  final SessionBloc _sessionBloc;

  SignInBloc(this._authService, this._sessionBloc) : super(const ResultState.idle()) {
    on<_SignIn>((event, emit) async {
      emit(const ResultState.loading());
      ApiResult<String> apiResult = await _authService.signIn(event.emailAddress, event.password);
      apiResult.when(
        success: (String response) async {
          _sessionBloc.add(const SessionEvent.initStartup());
          emit(ResultState.data(data: response));
        },
        failure: (NetworkExceptions error) async {
          emit(ResultState.error(error: error));
        },
      );
    });
  }
}