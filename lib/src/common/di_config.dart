import 'dart:io';

import 'package:app_auth/app_auth.dart';
import 'package:app_core/app_core.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_package_structure/sample_package_structure.dart';

import 'app_router.dart';

// import 'package:http/http.dart' as http;

// class ClientWithUserAgent extends BaseClient {
//   final http.Client _client;

//   ClientWithUserAgent(this._client);

//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) async {
//     request.headers['User-Agent'] = 'Mozilla/5.0 (Linux; Android 15) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.6613.127 Mobile Safari/537.36';
//     return _client.send(request);
//   }
// }

class DIConfig {
  static configure() async {
    final logger = AppLogger('DIConfig');
    logger.debug('Configuring DI - start');

    try {
      final AppRouter router = AppRouter();
      final IAuthService authService = AuthService();
      final ISampleService sampleService = SampleService();

      GetIt.I.registerSingleton<AppRouter>(router);
      GetIt.I.registerSingleton<IAuthService>(authService);
      GetIt.I.registerSingleton<ISampleService>(sampleService);
    } on Exception catch (e) {
      logger.info('Error configuring DI: $e');
      rethrow;
    }

    logger.debug('Configuring DI - end');
  }
}
