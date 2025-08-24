import 'package:app_auth/app_auth.dart';

abstract class IAuthService {
  Stream<AuthIdentity> get authStream;
  AuthIdentity? get currentIdentity;
  Future<AuthIdentity?> login();
  Future<void> logout();
}
