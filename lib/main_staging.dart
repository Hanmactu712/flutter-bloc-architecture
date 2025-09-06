import 'dart:developer';

import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_architecture_template/src/common/common.dart';
import 'package:flutter_bloc_architecture_template/src/my_app.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  setPathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
    ),
  );

  Logger.root.onRecord.listen((record) {
    log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });

  var logger = AppLogger('main');

  logger.debug('Starting app...');

  await DIConfig.configure(
    env: Environment.staging,
  );

  FlutterNativeSplash.remove();

  logger.debug('App started');

  runApp(MyApp());
}
