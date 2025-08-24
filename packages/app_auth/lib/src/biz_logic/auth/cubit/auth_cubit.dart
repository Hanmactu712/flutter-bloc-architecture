import 'dart:async';

import 'package:app_auth/app_auth.dart';
import 'package:app_core/app_core.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthService _authService;
  late StreamSubscription<AuthIdentity> _authSubscription;
  final AppLogger _logger = AppLogger('AuthCubit');
  AuthCubit({required IAuthService authService}) : _authService = authService, super(AuthInitial()) {
    _authSubscription = _authService.authStream.listen((user) {
      _logger.info('AuthCubit: user: ${user.id}');
      if (user.id.isNotEmpty) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  Future<void> login() async {
    await _authService.login();
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
