import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture_template/src/components/headers/headers.dart';

import 'app_footer.dart';

class AppMasterLayout extends StatelessWidget {
  final AdaptiveLayoutConfig? bodyConfig;
  final Widget? body;
  final bool showTopNavigation;
  final Function? onBack;
  final Function(bool, dynamic)? onPopped;
  AppMasterLayout({super.key, this.bodyConfig, this.body, this.showTopNavigation = true, this.onBack, this.onPopped}) {
    assert(bodyConfig != null || body != null, "body or bodyConfig must be provided");
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => onPopped?.call(didPop, result),
      child: AdaptiveLayout(
        padding: 0.0,
        bottomNavigation: const AdaptiveLayoutConfig(compactScreen: AppFooter()),
        topNavigation:
            showTopNavigation
                ? AdaptiveLayoutConfig(
                  inAnimation:
                      (child, animation) =>
                          SlideTransition(position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(animation), child: child),
                  outAnimation:
                      (child, animation) =>
                          SlideTransition(position: Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(animation), child: child),
                  expandedScreen: LargeHeader(showMenuButton: false, onBack: onBack),
                  compactScreen: CompactHeader(onBack: onBack),
                )
                : null,
        leftNavigation: AdaptiveLayoutConfig(
          inAnimation:
              (child, animation) => SlideTransition(position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(animation), child: child),
          outAnimation:
              (child, animation) => SlideTransition(position: Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0)).animate(animation), child: child),
          compactScreen: const SizedBox(),
        ),
        body: body != null ? AdaptiveLayoutConfig(compactScreen: body!) : bodyConfig!,
      ),
    );
  }
}
