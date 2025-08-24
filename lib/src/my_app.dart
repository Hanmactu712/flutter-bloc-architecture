import 'package:app_auth/app_auth.dart';
import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_template/src/localization/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  final _logger = AppLogger('MyApp');
  final GoRouter router = GetIt.I<GoRouter>();
  final IAuthService authService = GetIt.I<IAuthService>();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _logger.info('Building MyApp - start');
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => authService)],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => AuthCubit(authService: authService))],
        child: MaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
