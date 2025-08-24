import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_package_structure/src/components/sample_bloc_component/cubit/sample_bloc_component_cubit.dart';

class SampleBlocComponent extends StatelessWidget {
  const SampleBlocComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SampleBlocComponentCubit(),
      child: SizedBox(
        child: BlocBuilder<SampleBlocComponentCubit, SampleBlocComponentState>(
          builder: (context, state) {
            if (state is SampleBlocComponentInitial) {
              return CircularProgressIndicator();
            } else if (state is SampleBlocComponentLoaded) {
              return Text(state.data);
            } else {
              return Text('Error');
            }
          },
        ),
      ),
    );
  }
}
