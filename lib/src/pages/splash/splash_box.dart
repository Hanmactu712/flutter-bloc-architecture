import 'package:flutter/material.dart';

import 'splash.dart';

class SplashBox extends StatelessWidget {
  const SplashBox({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;

        var maxSize = width > height ? height : width;

        return SplashScreen(
          containerSize: maxSize / 1.5,
          tileSize: maxSize / 4.5,
        );
      },
    );
  }
}
