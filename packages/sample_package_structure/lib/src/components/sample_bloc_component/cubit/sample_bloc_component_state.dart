part of 'sample_bloc_component_cubit.dart';

sealed class SampleBlocComponentState extends Equatable {
  const SampleBlocComponentState();

  @override
  List<Object> get props => [];
}

final class SampleBlocComponentInitial extends SampleBlocComponentState {}

final class SampleBlocComponentLoading extends SampleBlocComponentState {}

final class SampleBlocComponentLoaded extends SampleBlocComponentState {
  final String data;

  const SampleBlocComponentLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class SampleBlocComponentError extends SampleBlocComponentState {
  final String message;

  const SampleBlocComponentError(this.message);

  @override
  List<Object> get props => [message];
}
