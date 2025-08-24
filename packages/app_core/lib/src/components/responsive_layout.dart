import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  ResponsiveLayout({Key? key, required this.child}) : super(key: key);

  final AppLogger _logger = AppLogger('ResponsiveLayout');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => OrientationBuilder(
        builder: (context, orientation) {
          Device.setDeviceDimension(
            constraints: constraints,
            orientation: orientation,
          );

          _logger.info('Device: ${Device.width}x${Device.height}');

          return child;
        },
      ),
    );
  }
}
