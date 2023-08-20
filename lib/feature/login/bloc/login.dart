import 'package:card/feature/login/service/auth_service.dart';
import 'package:card/feature/user/service/user_service.dart';
import 'package:fast_log/fast_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serviced/serviced.dart';

class LoginEvent {}

class LoginAppleEvent extends LoginEvent {}

class LoginGoogleEvent extends LoginEvent {}

enum LoginState { normal, loading, success, error }

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final bool logErrors;
  final bool analytics;

  LoginBloc({this.logErrors = true, this.analytics = true})
      : super(LoginState.normal) {
    on<LoginGoogleEvent>(loginWithGoogle);
  }

  Future<void> loginWithGoogle(
      LoginGoogleEvent event, Emitter<LoginState> emit) {
    emit(LoginState.loading);
    return svc<AuthService>()
        .signInWithGoogle()
        .then((value) => loginSuccess(emit))
        .catchError((e, es) => loginError(emit, e, es));
  }

  void loginError(Emitter<LoginState> emit, dynamic e, dynamic es) {
    if (logErrors) {
      error(e);
      error(es);
    }

    emit(LoginState.error);
    emit(LoginState.normal);
  }

  Future<void> loginSuccess(Emitter<LoginState> emit) {
    return svc<UserService>()
        .bind(svc<UserService>().uid())
        .then((value) => emit(LoginState.success))
        .then((value) => emit(LoginState.normal));
  }
}
