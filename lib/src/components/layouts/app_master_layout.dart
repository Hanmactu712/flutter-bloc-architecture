import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_template/src/components/headers/headers.dart';
import 'package:flutter_bloc_architecture_template/src/pages/settings/cubit/settings_cubit.dart';

import 'app_drawer.dart';
import 'app_footer.dart';
import 'app_menu_rail.dart';

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
        bottomNavigation: const AdaptiveLayoutConfig(compactScreen: AppBottomNavigator(), expandedScreen: AppFooter()),
        drawer: const AdaptiveLayoutConfig(compactScreen: AppDrawer(), mediumScreen: AppDrawer()),
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
          expandedScreen: Column(
            spacing: 8.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: const AppMenuRail()),
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  var isDark = state is SettingsLoaded && state.themeSettings.themeMode == ThemeMode.dark;
                  return IconButton(
                    icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    onPressed: () {
                      context.read<SettingsCubit>().toggleTheme();
                    },
                  );
                },
              ),
            ],
          ),
        ),
        body: body != null ? AdaptiveLayoutConfig(compactScreen: body!) : bodyConfig!,
      ),
    );
  }
}
