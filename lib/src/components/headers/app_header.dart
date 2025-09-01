import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture_template/src/common/common.dart';
import 'package:flutter_bloc_architecture_template/src/localization/app_localizations.dart';

import 'user_info.dart';

class CompactHeader extends StatelessWidget {
  final bool showMenuButton;
  final Function? onBack;
  const CompactHeader({super.key, this.showMenuButton = true, this.onBack});

  @override
  Widget build(BuildContext context) {
    var canBack = context.canBack();
    final locale = AppLocalizations.of(context)!;
    return Container(
      key: const Key("top-navigation-compact"),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), offset: const Offset(0, 1), blurRadius: 4)],
      ),
      height: 50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //back button
              if (canBack)
                BackButton(
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    if (onBack != null) {
                      onBack!();
                    } else {
                      context.routeBack();
                    }
                  },
                ),
              if (!canBack && showMenuButton) //show menu
                Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        //show hide drawer
                        if (Scaffold.of(context).isDrawerOpen) {
                          Scaffold.of(context).closeDrawer();
                        } else {
                          Scaffold.of(context).openDrawer();
                        }
                      },
                    );
                  },
                ),

              Container(
                padding: const EdgeInsets.all(8),
                child: Center(child: AppText(text: "Page title", style: context.titleMedium!.copyWith(fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 8),
              const UserInfo(avatarSize: 18),
            ],
          ),
        ],
      ),
    );
  }
}
