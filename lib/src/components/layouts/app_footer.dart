import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture_template/src/common/common.dart';
import 'package:flutter_bloc_architecture_template/src/pages/home/home_page.dart';
import 'package:flutter_bloc_architecture_template/src/pages/pages.dart';
import 'package:go_router/go_router.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), offset: const Offset(0, -1), blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [InkWell(onTap: () {}, child: const AppText(text: "Privacy Policy")), const AppText(text: "@2024 ducdang.dev")],
      ),
    );
  }
}

class AppBottomNavigator extends StatelessWidget {
  const AppBottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      // height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), offset: const Offset(0, -1), blurRadius: 4)],
      ),
      child: Builder(
        builder: (context) {
          return Row(
            children: [
              Expanded(child: BottomNavigationItem(icon: Icons.chat, routeTo: SamplePage.routeItem)),
              Expanded(child: BottomNavigationItem(icon: Icons.home, routeTo: HomePage.routeItem)),
              Expanded(child: BottomNavigationItem(icon: Icons.settings)),
            ],
          );
        },
      ),
    );
  }
}

class BottomNavigationItem extends StatelessWidget {
  final IconData icon;
  RouterItem? routeTo;

  BottomNavigationItem({super.key, required this.icon, this.routeTo});

  @override
  Widget build(BuildContext context) {
    var currentPath = GoRouter.of(context).routeInformationProvider.value.uri.path;
    var isSelected = currentPath == routeTo?.path;
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        if (routeTo != null) {
          context.routeToPage(routeTo!);
        }
      },
      style: IconButton.styleFrom(
        backgroundColor: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
        foregroundColor: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
