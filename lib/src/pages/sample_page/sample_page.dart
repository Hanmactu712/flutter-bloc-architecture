import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture_template/src/common/common.dart';
import 'package:flutter_bloc_architecture_template/src/components/layouts/layouts.dart';
import 'package:sample_package_structure/sample_package_structure.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  static RouterItem routeItem = RouterItem(name: "sample", path: "/sample");

  @override
  Widget build(BuildContext context) {
    return AppMasterLayout(
      onPopped: (didPop, a) {
        if (context.canBack()) {
          context.routeBack();
        }
      },
      bodyConfig: AdaptiveLayoutConfig(compactScreen: Padding(padding: const EdgeInsets.all(12.0), child: SampleBlocList())),
    );
  }
}
