import 'package:app_auth/app_auth.dart';
import 'package:app_core/app_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_template/src/common/common.dart';
import 'package:flutter_bloc_architecture_template/src/pages/pages.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class RouteConfig extends Equatable {
  final RouterItem routeItem;
  final Map<String, dynamic> queryParameters;
  final Map<String, String> pathParameters;
  final Map<String, dynamic> extra;

  const RouteConfig({required this.routeItem, this.queryParameters = const {}, this.pathParameters = const {}, this.extra = const {}});

  @override
  List<Object?> get props => [routeItem, queryParameters, pathParameters, extra];
}

class AppRouter {
  final List<RouteConfig> routeStack = [];

  CustomTransitionPage<dynamic> _customTransitionPage({required Widget child}) {
    return CustomTransitionPage(
      key: UniqueKey(),
      child: child,
      transitionDuration: Duration.zero, //const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  GoRoute _customTransitionRoute({
    required String path,
    required GoRouterWidgetBuilder builder,
    String name = '',
    bool isSecure = false,
    List<GoRoute> routes = const [],
  }) {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        var child = builder(context, state);
        return _customTransitionPage(child: child);
      },
      routes: routes,
      redirect: (context, state) async {
        if (!isSecure) {
          return null;
        }

        var authState = context.read<AuthCubit>().state;

        if (authState is AuthInitial || authState is Unauthenticated) {
          return '${LoginPage.routeItem.path}?r=${state.uri.toString()}';
        }
        return null;
      },
    );
  }

  GoRouter get router => _router;
  late GoRouter _router;

  AppRouter() {
    routeStack.add(RouteConfig(routeItem: HomePage.routeItem));
    _router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _navigatorKey,
      initialLocation: HomePage.routeItem.path,
      observers: [RouteObserver()],
      routes: <RouteBase>[
        _customTransitionRoute(
          path: LoginPage.routeItem.path,
          name: LoginPage.routeItem.name,
          builder: (context, state) {
            var queryParams = state.uri.queryParameters;
            return LoginPage(
              onSuccess: () {
                if (queryParams['r'] != null) {
                  context.go(queryParams['r']!);
                } else {
                  // context.go(HomePage.routeItem.path);
                  context.routeToPage(HomePage.routeItem, clearHistory: true);
                }
              },
            );
          },
        ),
        _customTransitionRoute(path: HomePage.routeItem.path, name: HomePage.routeItem.name, isSecure: true, builder: (context, state) => const HomePage()),
        _customTransitionRoute(
          path: SamplePage.routeItem.path,
          name: SamplePage.routeItem.name,
          isSecure: true,
          builder: (context, state) => const SamplePage(),
        ),
      ],
      errorBuilder: (context, state) => const ErrorPage(message: "Page not found"),
    );
  }

  //build method to get current AppRouter from context.of
  static AppRouter of(BuildContext context) {
    return GetIt.I<AppRouter>();
  }
}

extension RoutingExtension on BuildContext {
  void routeToPage(
    RouterItem routeItem, {
    Map<String, dynamic>? extra,
    Map<String, String>? queryParameters,
    Map<String, String>? pathParameters,
    bool clearHistory = false,
  }) {
    var router = GoRouter.of(this);
    var appRouter = AppRouter.of(this);
    if (clearHistory) {
      appRouter.routeStack.clear();
      appRouter.routeStack.add(
        RouteConfig(routeItem: routeItem, queryParameters: queryParameters ?? {}, pathParameters: pathParameters ?? {}, extra: extra ?? {}),
      );
      router.goNamed(routeItem.name, extra: extra, queryParameters: queryParameters ?? {}, pathParameters: pathParameters ?? {});
    } else {
      router.goNamed(routeItem.name, extra: extra, queryParameters: queryParameters ?? {}, pathParameters: pathParameters ?? {});
      appRouter.routeStack.add(
        RouteConfig(routeItem: routeItem, queryParameters: queryParameters ?? {}, pathParameters: pathParameters ?? {}, extra: extra ?? {}),
      );
    }
  }

  void routeBack() {
    var router = GoRouter.of(this);
    var appRouter = AppRouter.of(this);

    if (appRouter.routeStack.length > 1) {
      appRouter.routeStack.removeLast();
      var lastRoute = appRouter.routeStack.last;
      router.goNamed(lastRoute.routeItem.name, extra: lastRoute.extra, queryParameters: lastRoute.queryParameters, pathParameters: lastRoute.pathParameters);
    }
  }

  String currentRoutePath() {
    var appRouter = AppRouter.of(this);
    return appRouter.routeStack.isNotEmpty ? appRouter.routeStack.last.routeItem.path : '/';
  }

  bool canBack() {
    return AppRouter.of(this).routeStack.length > 1;
  }
}
