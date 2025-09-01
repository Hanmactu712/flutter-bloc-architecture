import 'package:app_auth/app_auth.dart';
import 'package:app_core/app_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_template/src/common/common.dart';
import 'package:flutter_bloc_architecture_template/src/pages/pages.dart';
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
    _router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _navigatorKey,
      initialLocation: HomePage.routeItem.path,
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
    if (clearHistory) {
      while (router.canPop()) {
        router.pop();
      }
      // router.pushNamed(routeItem.name, queryParameters: queryParameters ?? {}, pathParameters: pathParameters ?? {}, extra: extra ?? {});
      router.go(routeItem.path, extra: extra);
    } else {
      // Prevent routing if already on the target page with same parameters
      final currentState = GoRouter.of(this).routerDelegate.currentConfiguration;
      final isSameRoute = currentState.fullPath == routeItem.path;

      if (!isSameRoute) {
        // router.pushNamed(routeItem.name, extra: extra, queryParameters: queryParameters ?? {}, pathParameters: pathParameters ?? {});
        router.go(routeItem.path, extra: extra);
      }
    }
  }

  void routeBack() {
    var router = GoRouter.of(this);

    if (router.canPop()) {
      router.pop();
    }
  }

  String currentRoutePath() {
    return GoRouter.of(this).routeInformationProvider.value.uri.path;
  }

  bool canBack() {
    var router = GoRouter.of(this);
    return router.canPop();
  }
}
