import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_package_structure/src/pages/sample_bloc_page/cubit/sample_bloc_page_cubit.dart';

class SampleBlocPage extends StatelessWidget {
  const SampleBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SampleBlocPageCubit(),
      child: BlocBuilder<SampleBlocPageCubit, SampleBlocPageState>(
        builder: (context, state) {
          if (state is SampleBlocPageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SampleBlocPageLoaded) {
            return Center(child: Text(state.data));
          } else if (state is SampleBlocPageError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
