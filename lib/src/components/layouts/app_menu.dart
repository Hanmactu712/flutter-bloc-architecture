import 'package:app_core/src/common/constant.dart';
import 'package:flutter/material.dart';

class DraggableMenu extends StatelessWidget {
  const DraggableMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70,
      // padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.5), blurRadius: 4, offset: const Offset(2, 2))],
      ),
      child: IconButton.filled(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimaryContainer),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        icon: Icon(AppIcons.menu),
        onPressed: () {
          //toggle drawer
          if (Scaffold.of(context).isDrawerOpen) {
            Scaffold.of(context).closeDrawer();
          } else {
            Scaffold.of(context).openDrawer();
          }
        },
      ),
    );
  }
}
