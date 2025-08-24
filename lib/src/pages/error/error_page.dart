import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture_template/src/common/common.dart';

import 'app_error_widget.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  const ErrorPage({super.key, required this.message});

  static RouterItem routeItem = RouterItem(name: 'ErrorPage', path: '/error');

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      body: AdaptiveLayoutConfig(
        compactScreen: Center(
          child: AppErrorWidget(
            message: message,
            onBack: () {
              context.routeBack();
            },
          ),
        ),
      ),
    );
  }
}
