import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture_template/src/common/common.dart';
import 'package:flutter_bloc_architecture_template/src/components/layouts/layouts.dart';
import 'package:flutter_bloc_architecture_template/src/pages/home/cubit/home_cubit.dart';

import '../error/error.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static RouterItem routeItem = RouterItem(name: "home", path: "/");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadData(),
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) => current is HomeReceiveSharedMarker,
        listener: (context, state) {},
        child: AppMasterLayout(
          onPopped: (didPop, a) {
            if (context.canBack()) {
              context.routeBack();
            }
          },
          bodyConfig: AdaptiveLayoutConfig(
            compactScreen: Padding(
              padding: const EdgeInsets.all(12.0),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadedError) {
                    return Center(
                      child: AppErrorWidget(
                        message: state.message,
                        onBack: () {
                          context.read<HomeCubit>().loadData();
                        },
                      ),
                    );
                  }
                  if (state is HomeLoadedSuccess) {
                    return Column(children: []);
                  }
                  return const Center(child: CircularProgressIndicator.adaptive());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
