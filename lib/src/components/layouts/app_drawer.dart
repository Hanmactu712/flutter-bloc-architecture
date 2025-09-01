import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_template/src/pages/pages.dart';

import 'app_menu_rail.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key("left-drawer-compact"),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.all(Radius.circular(10))),
      width: 280,
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(24.0), child: AppLogo()),
          const Expanded(child: AppMenuRail(isExpanded: true, widthConfig: LayoutConfig<double>(compactScreen: 260))),
          //setting for dark/light theme
          Divider(),
          Row(
            spacing: 8.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              //label
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return Text(
                    state is SettingsLoaded
                        ? (state.themeSettings.themeMode == ThemeMode.dark
                            ? "Dark"
                            : state.themeSettings.themeMode == ThemeMode.light
                            ? "Light"
                            : "System")
                        : "Loading...",
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
