import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

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
          Container(
            height: 100,
            margin: const EdgeInsets.all(8.0),
            color: Theme.of(context).colorScheme.surface,
            child: Center(child: Column(children: [AppText(text: "MY MARKER", style: context.headlineMedium!.copyWith(fontWeight: FontWeight.bold))])),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
