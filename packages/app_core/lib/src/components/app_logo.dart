import 'package:app_core/src/common/constant.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(vertical: 8.0), child: SizedBox(child: Image.asset(Resources.logo, fit: BoxFit.scaleDown)));
  }
}
