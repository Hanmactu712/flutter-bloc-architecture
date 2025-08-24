import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sample_bloc_component_state.dart';

class SampleBlocComponentCubit extends Cubit<SampleBlocComponentState> {
  SampleBlocComponentCubit() : super(SampleBlocComponentInitial());
}
