import 'package:app_auth/app_auth.dart';
import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_template/src/common/app_router.dart';
import 'package:flutter_bloc_architecture_template/src/localization/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_package_structure/sample_package_structure.dart';

import 'pages/settings/cubit/settings_cubit.dart';

class MyApp extends StatelessWidget {
  final _logger = AppLogger('MyApp');
  final GoRouter router = GetIt.I<AppRouter>().router;
  final IAuthService authService = GetIt.I<IAuthService>();
  final ISampleService sampleService = GetIt.I<ISampleService>();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _logger.info('Building MyApp - start');
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => authService), RepositoryProvider(create: (context) => sampleService)],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => AuthCubit(authService: authService)), BlocProvider(create: (context) => SettingsCubit()..loadData())],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ThemeProvider(
              lightDynamic: null,
              darkDynamic: null,
              settings: ThemeSettings(
                sourceColor: state is SettingsLoaded ? state.themeSettings.sourceColor : Constant.primaryColor,
                themeMode: state is SettingsLoaded ? state.themeSettings.themeMode : ThemeMode.system,
              ),
              child: Builder(
                builder: (context) {
                  var theme = ThemeProvider.of(context);
                  return MaterialApp.router(
                    routerDelegate: router.routerDelegate,
                    routeInformationParser: router.routeInformationParser,
                    routeInformationProvider: router.routeInformationProvider,
                    debugShowCheckedModeBanner: false,
                    theme: theme.light(),
                    darkTheme: theme.dark(),
                    themeMode: theme.themeMode(),
                    localizationsDelegates: AppLocalizations.localizationsDelegates,
                    locale: state is SettingsLoaded ? state.locale : null,
                    supportedLocales: AppLocalizations.supportedLocales,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
