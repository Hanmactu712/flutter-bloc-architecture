import 'dart:async';

import 'package:app_auth/app_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_page_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final IAuthService _authService;
  late StreamSubscription<AuthIdentity> _authSubscription;
  LoginCubit({required IAuthService authService}) : _authService = authService, super(const LoginState.initial()) {
    _authSubscription = _authService.authStream.listen((user) {
      _emitState(state.copyWith(identity: user, status: FormzSubmissionStatus.success));
    });
  }

  Future<void> login() async {
    try {
      _emitState(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await _authService.login();
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  _emitState(LoginState state) {
    if (isClosed) return;
    emit(state);
  }

  changeUser(String value) {
    var currentState = state;
    final email = EmailInput.dirty(value);
    _emitState(currentState.copyWith(email: email, isValid: Formz.validate([email, currentState.password])));
  }

  changePassword(String value) {
    var currentState = state;
    final password = PasswordInput.dirty(value);
    _emitState(currentState.copyWith(password: password, isValid: Formz.validate([currentState.email, password])));
  }
}
