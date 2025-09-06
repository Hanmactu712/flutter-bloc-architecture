import 'package:app_auth/app_auth.dart';
import 'package:app_core/app_core.dart';
import 'package:get_it/get_it.dart';
import 'package:sample_package_structure/sample_package_structure.dart';

import 'app_router.dart';

class DIConfig {
  static configure({required Environment env}) async {
    final logger = AppLogger('DIConfig');
    logger.debug('Configuring DI - start');

    try {
      EnvironmentConfig config = EnvironmentConfig.development;

      switch (env) {
        case Environment.testing:
          config = EnvironmentConfig.testing;
          break;
        case Environment.staging:
          config = EnvironmentConfig.staging;
          break;
        case Environment.production:
          config = EnvironmentConfig.production;
          break;
        default:
          config = EnvironmentConfig.development;
      }

      GetIt.I.registerSingleton<EnvironmentConfig>(config);

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
