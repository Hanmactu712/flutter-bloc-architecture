import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture_template/src/common/common.dart';
import 'package:go_router/go_router.dart';

class AppMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final RouterItem routeTo;
  final bool iconOnly;

  const AppMenuItem({super.key, required this.icon, required this.text, required this.routeTo, this.iconOnly = false});

  @override
  Widget build(BuildContext context) {
    var currentPath = GoRouter.of(context).routeInformationProvider.value.uri.path;
    var isSelected = currentPath == routeTo.path;
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.routeToPage(routeTo);
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface),
                  if (!iconOnly) ...[
                    Constant.spacerSm,
                    AppText(
                      text: text,
                      style: context.labelMedium!.copyWith(
                        color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
