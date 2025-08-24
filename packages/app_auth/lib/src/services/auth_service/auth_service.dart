import 'dart:async';
import 'dart:convert';

import 'package:app_auth/app_auth.dart';
import 'package:app_core/app_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends IAuthService {
  final Future<SharedPreferences> instanceFuture = SharedPreferences.getInstance();
  final _controller = StreamController<AuthIdentity>.broadcast();

  AuthIdentity? _currentUser;
  final AppLogger _logger = AppLogger('AuthService');

  AuthService();

  @override
  AuthIdentity? get currentIdentity => _currentUser;

  @override
  Stream<AuthIdentity> get authStream => _controller.stream;

  @override
  logout() async {
    var store = await instanceFuture;
    store.remove(Constant.LS_Identity);
    _currentUser = null;
    _controller.add(AuthIdentity(id: '', userName: '', email: ''));
  }

  @override
  Future<AuthIdentity?> login() async {
    try {
      var store = await instanceFuture;

      var identityStr = store.getString(Constant.LS_Identity);
      if (identityStr != null) {
        var identity = AuthIdentity.fromJson(jsonDecode(identityStr));

        _currentUser = identity;
        _controller.add(identity);
        return identity;
      }

      var auth = AuthIdentity(id: 'userId', userName: "Dang Dinh Duc", email: "sample@example.com");

      store.setString(Constant.LS_Identity, jsonEncode(auth.toJson()));
      _controller.add(auth);
      return auth;
    } on Exception catch (e) {
      _logger.debug('AuthService: $e');
    }
    return null;
  }
}
